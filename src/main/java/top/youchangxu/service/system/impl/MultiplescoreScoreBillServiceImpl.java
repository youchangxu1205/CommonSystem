package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.common.exception.InsertException;
import top.youchangxu.common.exception.OutOfRangeScoreException;
import top.youchangxu.mapper.system.MultiplescoreScoreBillMapper;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.MultiplescoreScoreBillDetail;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.service.system.IMultiplescoreScoreBillDetailService;
import top.youchangxu.service.system.IMultiplescoreScoreBillService;
import top.youchangxu.service.system.IStaffingEmpService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Service
public class MultiplescoreScoreBillServiceImpl extends ServiceImpl<MultiplescoreScoreBillMapper, MultiplescoreScoreBill> implements IMultiplescoreScoreBillService {
    @Autowired
    private IMultiplescoreScoreBillDetailService multiplescoreScoreBillDetailService;
    @Autowired
    private IStaffingEmpService staffingEmpService;

    @Override
    public boolean saveScoreBill(String bills, Long drawerID, String billTime, String scoreBillDesc, Long enterpriseId) {


        StaffingEmp staffingEmp = staffingEmpService.selectById(drawerID);
        //保存单据
        MultiplescoreScoreBill multiplescoreScoreBill = new MultiplescoreScoreBill();
        multiplescoreScoreBill.setDrawerId(drawerID);
        multiplescoreScoreBill.setScoreBillStatus(1);//待审核
        multiplescoreScoreBill.setScoreBillDesc(scoreBillDesc);
        multiplescoreScoreBill.setEnable(true);
        multiplescoreScoreBill.setEnterpriseId(enterpriseId);
        multiplescoreScoreBill.setDrawerName(staffingEmp.getEmpName());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Integer count = baseMapper.selectCount(
                new EntityWrapper<MultiplescoreScoreBill>()
                        .like("billTime", billTime));
        multiplescoreScoreBill.setScoreBillNo("JFKD" + billTime + "-000" + (count + 1));
        try {
            multiplescoreScoreBill.setBillTime(simpleDateFormat.parse(billTime));
        } catch (ParseException e) {
            return false;
        }


        insert(multiplescoreScoreBill);

        List<MultiplescoreScoreBillDetail> multiplescoreScoreBillDetails = JSON.parseArray(bills, MultiplescoreScoreBillDetail.class);

        for (MultiplescoreScoreBillDetail multiplescoreScoreBillDetail :
                multiplescoreScoreBillDetails) {
            multiplescoreScoreBillDetail.setScoreBillId(multiplescoreScoreBill.getScoreBillId());
            multiplescoreScoreBillDetail.setEnable(true);
            multiplescoreScoreBillDetail.setEnterpriseId(enterpriseId);
            if (multiplescoreScoreBillDetail.getIsFixed() == 1&& multiplescoreScoreBillDetail.getScoreBillDetailScore() > 0) {
                boolean b = multiplescoreScoreBillDetailService
                        .checkEmpScoreIsMoreEventScore(
                                multiplescoreScoreBillDetail.getDraweeId(),
                                multiplescoreScoreBillDetail.getEventId(),
                                billTime,
                                multiplescoreScoreBillDetail.getScoreBillDetailScore(), enterpriseId);
                if (!b) {
                    throw new OutOfRangeScoreException(
                            multiplescoreScoreBillDetail.getDraweeName() + "在" + multiplescoreScoreBillDetail.getEventName() + "的分值已经超出了范围");
                }
            }

        }

        //保存单据详情

        boolean insertBatch = multiplescoreScoreBillDetailService.insertBatch(multiplescoreScoreBillDetails);
        if(!insertBatch){
            throw new InsertException("保存失败");
        }

        return insertBatch;
    }
}
