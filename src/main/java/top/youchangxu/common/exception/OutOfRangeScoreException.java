package top.youchangxu.common.exception;

/**
 * Created by dtkj_android on 2017/6/16.
 */
public class OutOfRangeScoreException extends RuntimeException {
    public OutOfRangeScoreException() {
    }

    public OutOfRangeScoreException(String message) {
        super(message);
    }

    public OutOfRangeScoreException(String message, Throwable cause) {
        super(message, cause);
    }
}
