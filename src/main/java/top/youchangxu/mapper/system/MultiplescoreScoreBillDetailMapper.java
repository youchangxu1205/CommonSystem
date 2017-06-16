package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;

/**
 * Created by dtkj_android on 2017/6/14.
 */
public interface MultiplescoreScoreBillDetailMapper extends BaseMapper<MultiplescoreScoreBillDetail> {
    float selectEmpEventScoreInMonth(@Param("draweeId") Long draweeId,@Param("eventId") Long eventId,@Param("billTime") String billTime,@Param("enterpriseId") Long enterpriseId);
}
