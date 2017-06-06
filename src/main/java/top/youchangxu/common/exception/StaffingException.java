package top.youchangxu.common.exception;

/**
 * Created by dtkj_android on 2017/6/6.
 */
public class StaffingException extends RuntimeException{
    public StaffingException() {
    }

    public StaffingException(String message) {
        super(message);
    }

    public StaffingException(String message, Throwable cause) {
        super(message, cause);
    }
}
