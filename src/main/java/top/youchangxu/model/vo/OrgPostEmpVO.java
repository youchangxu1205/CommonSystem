package top.youchangxu.model.vo;

import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingOrg;
import top.youchangxu.model.system.StaffingPost;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/16.
 */
public class OrgPostEmpVO extends StaffingEmp {

    private List<StaffingOrg> staffingOrgList;

    private List<StaffingPost> staffingPostList;

    public List<StaffingOrg> getStaffingOrgList() {
        return staffingOrgList;
    }

    public void setStaffingOrgList(List<StaffingOrg> staffingOrgList) {
        this.staffingOrgList = staffingOrgList;
    }

    public List<StaffingPost> getStaffingPostList() {
        return staffingPostList;
    }

    public void setStaffingPostList(List<StaffingPost> staffingPostList) {
        this.staffingPostList = staffingPostList;
    }
}
