package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescoreScoreBill;

import java.util.Date;

/**
 * Created by dtkj_android on 2017/6/14.
 */
public interface IMultiplescoreScoreBillService extends IService<MultiplescoreScoreBill> {
    boolean saveScoreBill(String bills, Long drawerID, String billTime, String scoreBillDesc, Long enterpriseId);
}
