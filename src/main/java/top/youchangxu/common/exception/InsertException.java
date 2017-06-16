package top.youchangxu.common.exception;

/**
 * Created by dtkj_android on 2017/6/16.
 */
public class InsertException extends RuntimeException {
    public InsertException() {
    }

    public InsertException(String message) {
        super(message);
    }

    public InsertException(String message, Throwable cause) {
        super(message, cause);
    }
}
