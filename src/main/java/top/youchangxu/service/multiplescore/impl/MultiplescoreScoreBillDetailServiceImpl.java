package top.youchangxu.service.multiplescore.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplescoreScoreBillDetailMapper;
import top.youchangxu.model.system.MultiplescoreEvent;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;
import top.youchangxu.service.multiplescore.IMultiplescoreEventService;
import top.youchangxu.service.multiplescore.IMultiplescoreScoreBillDetailService;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Service("multiplescoreScoreBillDetailService")
public class MultiplescoreScoreBillDetailServiceImpl extends ServiceImpl<MultiplescoreScoreBillDetailMapper, MultiplescoreScoreBillDetail> implements IMultiplescoreScoreBillDetailService {
    @Autowired
    private IMultiplescoreEventService multiplescoreEventService;

    @Override
    public boolean checkEmpScoreIsMoreEventScore(Long draweeId, Long eventId, String billTime, float currentScore, Long enterpriseId) {
        //TODO
        //获取事件的单人单月最高奖分的分值
        MultiplescoreEvent multiplescoreEvent = multiplescoreEventService.selectById(eventId);
        float eventScore = multiplescoreEvent.getEventScore();


        //获取该员工在该企业内因为这个事件在billTime所在月份的总奖分
        float empEventScoreInMonth = baseMapper.selectEmpEventScoreInMonth(draweeId, eventId, billTime, enterpriseId);
        if (empEventScoreInMonth + currentScore > eventScore) {
            return false;
        }
        return true;
    }
}
