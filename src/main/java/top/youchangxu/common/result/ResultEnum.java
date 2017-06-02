package top.youchangxu.common.result;

/**
 * Created by dtkj_android on 2017/6/1.
 */
public enum ResultEnum {
    INSERT_SUCCESS(101,"添加成功"),
    INSERT_ERROR(-101,"添加失败"),
    UPDATE_SUCCESS(102,"修改成功"),
    UPDATE_ERROR(-102,"修改失败"),
    DELETE_SUCCESS(103,"删除成功"),
    DELETE_ERROR(-103,"删除失败"),
    ACCOUNT_OR_PASSWORD_IS_WRONG(104,"账号或密码错误"),
    REPEAT_LOGIN_TO_MUCH(105,"重试次数过多,请10分钟再试"),
    SERVER_HAS_BUSY(106,"服务器错误"),
    USERNAME_HAS_EXITS(107,"用户名已存在")
    ;

    private int code;
    private String msg;

    ResultEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }


    public static String getMsg(int code){
        for (ResultEnum resultEnum : ResultEnum.values()) {
            if (resultEnum.getCode() == code) {
                return resultEnum.msg;
            }
        }
        return null;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
