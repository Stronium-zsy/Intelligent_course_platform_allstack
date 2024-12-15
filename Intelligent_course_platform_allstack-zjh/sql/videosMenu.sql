-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频', '3', '1', 'videos', 'system/videos/index', 1, 0, 'C', '0', '0', 'system:videos:list', '#', 'admin', sysdate(), '', null, '课程视频菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:videos:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:videos:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:videos:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:videos:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程视频导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:videos:export',       '#', 'admin', sysdate(), '', null, '');