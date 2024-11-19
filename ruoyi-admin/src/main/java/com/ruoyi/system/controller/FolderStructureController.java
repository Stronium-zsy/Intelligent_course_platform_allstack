package com.ruoyi.system.controller;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.system.domain.CourseUser;
import com.ruoyi.system.service.ICourseUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.ISysRoleService;

@RestController
@RequestMapping("/system/folder")
public class FolderStructureController extends BaseController {

    @Autowired
    private ISysRoleService roleService;

    @Autowired
    private ICourseUserService courseUserService;


    /**
     * 获取文件夹结构
     */
//    @PreAuthorize("@ss.hasPermi('system:folder:list')")
    @Log(title = "文件夹访问", businessType = BusinessType.OTHER)
    @GetMapping("/structure")
    public AjaxResult getFolderStructure(@RequestParam(required = false) Long courseId) {
        try {
            // 1. 获取当前用户信息
            Long userId= SecurityUtils.getUserId();
            CourseUser courseUser = new CourseUser();
            courseUser.setUserId(userId);
            courseUser.setCourseId(courseId);
            Boolean isValid = courseUserService.selectCourseUserList(courseUser).stream()
                    .anyMatch(cu -> cu.getUserId().equals(userId));

            if (!isValid) {
                return AjaxResult.error("无访问权限");
            }

            String requestPath = "E:\\IdeaProjects\\Intelligent_course_platform\\courseMaterial\\"+courseId+"\\materialType\\courseFiles";

            // 5. 检查目录是否存在
            File baseDir = new File(requestPath);
            if (!baseDir.exists() || !baseDir.isDirectory()) {
                return AjaxResult.error("指定的目录不存在");
            }

            // 6. 获取并返回文件夹结构
            List<FileNode> structure = getStructure(baseDir, requestPath);


            return AjaxResult.success(structure);

        } catch (Exception e) {
            logger.error("访问文件夹结构失败", e);
            return AjaxResult.error("系统错误");
        }
    }




    /**
     * 递归获取文件夹结构
     */
    public static List<FileNode> getStructure(File directory, String basePath) {
        List<FileNode> nodes = new ArrayList<>();
        File[] files = directory.listFiles();

        // 打印当前目录和文件列表
        System.out.println("Processing directory: " + directory.getAbsolutePath());
        if (files != null) {
            System.out.println("Found files:");
            for (File file : files) {
                // 打印每个文件的信息
                System.out.println("  - " + file.getName() + (file.isDirectory() ? " [D]" : " [F]"));
            }
        } else {
            System.out.println("No files found or cannot read the directory.");
        }

        // 打印 basePath
        System.out.println("Base path: " + basePath);

        if (files != null) {
            for (File file : files) {
                // 跳过隐藏文件和特殊文件
                if (file.isHidden() || file.getName().startsWith(".")) {
                    continue;
                }

                FileNode node = new FileNode();
                node.setName(file.getName());
                node.setDirectory(file.isDirectory());

                // 计算相对路径
                String relativePath = Paths.get(basePath)
                        .relativize(Paths.get(file.getAbsolutePath()))
                        .toString();
                if(file.isDirectory()){
                    node.setPath((basePath+"\\"+relativePath).substring("E:\\IdeaProjects\\Intelligent_course_platform".length()));
                }else{
                    node.setPath((basePath + "\\" + file.getName()).substring("E:\\IdeaProjects\\Intelligent_course_platform".length()));
                }


                // 如果是目录，递归获取子文件夹结构
                if (file.isDirectory()) {
                    System.out.println("Entering directory: " + file.getAbsolutePath());
                    List<FileNode> children = getStructure(file, basePath + "\\" + file.getName());
                    node.setChildren(children);
                } else {
                    // 如果是文件，设置文件大小
                    node.setSize(file.length());
                }

                nodes.add(node);
            }
        }

        return nodes;
    }
    public static void printStructure(List<FileNode> nodes, int depth) {
        for (FileNode node : nodes) {
            // 打印缩进结构
            System.out.println("  ".repeat(depth) + (node.isDirectory() ? "[D] " : "[F] ") + node.getName());
            if (node.isDirectory() && node.getChildren() != null) {
                printStructure(node.getChildren(), depth + 1);
            }
        }
    }


    /**
     * 文件节点实体类
     */
    static class FileNode {
        public String getName() {
            return name;
        }

        public boolean isDirectory() {
            return isDirectory;
        }

        public long getSize() {
            return size;
        }

        private String name;
        private String path;
        private boolean isDirectory;
        private long size;

        public List<FileNode> getChildren() {
            return children;
        }

        private List<FileNode> children = new ArrayList<>();
        // Getters and Setters
        public void setName(String name) {
            this.name = name;
        }

        public void setDirectory(boolean directory) {
            isDirectory = directory;
        }

        public void setSize(long size) {
            this.size = size;
        }

        public void setChildren(List<FileNode> children) {
            this.children = children;
        }

        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }

    }

}