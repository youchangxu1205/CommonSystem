package top.youchangxu.mapper.multiplescore;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Repository
public interface MultiplescoreScoreBillDetailMapper extends BaseMapper<MultiplescoreScoreBillDetail> {
    /**
     * 获取该员工在该企业内因为这个事件在billTime所在月份的总奖分
     * @param draweeId
     * @param eventId
     * @param billTime
     * @param enterpriseId
     * @return
     */
    float selectEmpEventScoreInMonth(@Param("draweeId") Long draweeId,@Param("eventId") Long eventId,@Param("billTime") String billTime,@Param("enterpriseId") Long enterpriseId);
}
