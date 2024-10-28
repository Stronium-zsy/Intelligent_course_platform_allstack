package com.ruoyi.system.service.impl;

import java.io.IOException;
import java.util.List;

import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.model.GridFSUploadOptions;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.CourseMaterialMapper;
import com.ruoyi.system.domain.CourseMaterial;
import com.ruoyi.system.service.ICourseMaterialService;
import org.springframework.web.multipart.MultipartFile;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-10-27
 */
@Service
public class CourseMaterialServiceImpl implements ICourseMaterialService 
{
    @Autowired
    private CourseMaterialMapper courseMaterialMapper;

    @Autowired
    private GridFSBucket gridFSBucket; // 注入 GridFSBucket

    /**
     * 查询【请填写功能名称】
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public CourseMaterial selectCourseMaterialByMaterialId(Long materialId)
    {
        return courseMaterialMapper.selectCourseMaterialByMaterialId(materialId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<CourseMaterial> selectCourseMaterialList(CourseMaterial courseMaterial)
    {
        return courseMaterialMapper.selectCourseMaterialList(courseMaterial);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param file,courseId【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertCourseMaterial(MultipartFile file, Long courseId) {
        try {
            // 将文件流存储到 MongoDB 的 GridFS 中
            ObjectId fileId = gridFSBucket.uploadFromStream(
                    file.getOriginalFilename(),
                    file.getInputStream(),
                    new GridFSUploadOptions().metadata(new Document("contentType", file.getContentType()))
            );

            // 构建 CourseMaterial 对象，将 MongoDB 文件 ID 作为文件路径保存到 MySQL
            CourseMaterial courseMaterial = new CourseMaterial();
            courseMaterial.setCourseId(courseId);
            courseMaterial.setFilePath(fileId.toHexString()); // 存储 MongoDB 文件 ID
            courseMaterial.setTitle(file.getOriginalFilename()); // 存储文件名
            // 将路径信息保存到 MySQL 中
            return courseMaterialMapper.insertCourseMaterial(courseMaterial);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("文件上传到 MongoDB 失败：" + e.getMessage());
        }
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param courseMaterial 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateCourseMaterial(CourseMaterial courseMaterial)
    {
        return courseMaterialMapper.updateCourseMaterial(courseMaterial);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param materialIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseMaterialByMaterialIds(Long[] materialIds)
    {
        return courseMaterialMapper.deleteCourseMaterialByMaterialIds(materialIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param materialId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteCourseMaterialByMaterialId(Long materialId)
    {
        return courseMaterialMapper.deleteCourseMaterialByMaterialId(materialId);
    }
}
