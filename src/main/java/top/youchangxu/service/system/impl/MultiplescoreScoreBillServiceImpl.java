package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.MultiplescoreScoreBillMapper;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;
import top.youchangxu.service.system.IMultiplescoreScoreBillDetailService;
import top.youchangxu.service.system.IMultiplescoreScoreBillService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Service
public class MultiplescoreScoreBillServiceImpl extends ServiceImpl<MultiplescoreScoreBillMapper, MultiplescoreScoreBill> implements IMultiplescoreScoreBillService {
    @Autowired
    private IMultiplescoreScoreBillDetailService multiplescoreScoreBillDetailService;

    @Override
    public boolean saveScoreBill(String bills, Long drawerID, String billTime, String scoreBillDesc, Long enterpriseId) {

        //保存单据
        MultiplescoreScoreBill multiplescoreScoreBill = new MultiplescoreScoreBill();
        multiplescoreScoreBill.setDrawerId(drawerID);
        multiplescoreScoreBill.setScoreBillStatus(1);//待审核
        multiplescoreScoreBill.setScoreBillDesc(scoreBillDesc);
        multiplescoreScoreBill.setEnable(true);
        multiplescoreScoreBill.setEnterpriseId(enterpriseId);


        baseMapper.insert(multiplescoreScoreBill);

        List<MultiplescoreScoreBillDetail> multiplescoreScoreBillDetails = JSON.parseArray(bills, MultiplescoreScoreBillDetail.class);

        for (MultiplescoreScoreBillDetail multiplescoreScoreBillDetail :
                multiplescoreScoreBillDetails) {
            multiplescoreScoreBillDetail.setScoreBillId(multiplescoreScoreBill.getScoreBillId());
            multiplescoreScoreBillDetail.setEnable(true);
            multiplescoreScoreBillDetail.setEnterpriseId(enterpriseId);
        }

        //保存单据详情
        boolean insertBatch = multiplescoreScoreBillDetailService.insertBatch(multiplescoreScoreBillDetails);

        return insertBatch;
    }
}
