package top.youchangxu.model.vo;

/**
 * Created by dtkj_android on 2017/6/12.
 */
public class PostRangeVO {
    private Long postId;
    private String orgPathName;
    private String postName;
    private String postEmpName;

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public String getOrgPathName() {
        return orgPathName;
    }

    public void setOrgPathName(String orgPathName) {
        this.orgPathName = orgPathName;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPostEmpName() {
        return postEmpName;
    }

    public void setPostEmpName(String postEmpName) {
        this.postEmpName = postEmpName;
    }
}
