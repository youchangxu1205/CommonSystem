package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingPermissionMapper;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.service.system.IStaffingPermissionService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Service
public class StaffingPermissionServiceImpl extends ServiceImpl<StaffingPermissionMapper, StaffingPermission> implements IStaffingPermissionService {


    @Override
    public List<StaffingPermission> selectPermissionByUsername(String username) {

        return null;
    }

    @Override
    public JSONArray getTreeByRoleId(Long roleId) {
        //根据角色查询权限列表
//        List<StaffingPermission> staffingRolePermissions
//                = baseMapper.selectPermissionByRoleId(roleId);
        //查询所有的权限
        //目录
        JSONArray folders = new JSONArray();
        //获取目录权限
        List<StaffingPermission> staffingPermissionFolders
                = baseMapper.selectList(new EntityWrapper<StaffingPermission>().eq("pPermissionId", 0));
        for (StaffingPermission staffingPermissionFolder :
                staffingPermissionFolders) {
            JSONObject folder = new JSONObject();
            folder.put("id", staffingPermissionFolder.getPermissionId());
            folder.put("name", staffingPermissionFolder.getPermissionName());
            folder.put("open", true);
            List<StaffingPermission> staffingPermissionMenus
                    = baseMapper.selectList(new EntityWrapper<StaffingPermission>()
                    .eq("pPermissionId", staffingPermissionFolder.getPermissionId()));
            //菜单
            JSONArray menus = new JSONArray();
            for (StaffingPermission staffingPermissionMenu :
                    staffingPermissionMenus) {
                JSONObject menu = new JSONObject();
                menu.put("id", staffingPermissionMenu.getPermissionId());
                menu.put("name", staffingPermissionMenu.getPermissionName());
                menu.put("open", true);
                //按钮
                JSONArray btns = new JSONArray();
                List<StaffingPermission> staffingPermissionBtns
                        = baseMapper.selectList(new EntityWrapper<StaffingPermission>()
                        .eq("pPermissionId", staffingPermissionMenu.getPermissionId()));

                for (StaffingPermission staffingPermissionBtn :
                        staffingPermissionBtns) {
                    JSONObject btn = new JSONObject();
                    btn.put("id", staffingPermissionBtn.getPermissionId());
                    btn.put("name", staffingPermissionBtn.getPermissionName());
                    btn.put("open", true);
                    btns.add(btn);
                }
                menu.put("children",btns);
                menus.add(menu);
            }
            folder.put("children",menus);
            folders.add(folder);
        }
        return folders;
    }
}
