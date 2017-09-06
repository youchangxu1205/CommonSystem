package top.youchangxu.service.multiplescore;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.multiplescore.MultiplescoreEmpRange;

/**
 * Created by dtkj_android on 2017/6/6.
 */
public interface IMultiplescoreEmpRangeService extends IService<MultiplescoreEmpRange> {
    int updateEmpRanges(String[] empIds, Long empId, String enterpriseId);
}
