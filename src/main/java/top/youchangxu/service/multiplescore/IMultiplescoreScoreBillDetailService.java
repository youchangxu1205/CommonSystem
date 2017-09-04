package top.youchangxu.service.multiplescore;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;

/**
 * Created by dtkj_android on 2017/6/14.
 */
public interface IMultiplescoreScoreBillDetailService extends IService<MultiplescoreScoreBillDetail> {
    /**
     * 检查员工是否因为某个事件的分值超出了单人单月最高奖分
     * @param draweeId
     * @param eventId
     * @param billTime
     * @param currentScore //当前奖分
     * @return
     */
    boolean checkEmpScoreIsMoreEventScore(Long draweeId,Long eventId,String billTime,float currentScore,Long enterpriseId);
}
