package top.youchangxu.service.multiplescore.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplescoreEmpRangeMapper;
import top.youchangxu.model.system.MultiplescoreEmpRange;
import top.youchangxu.service.multiplescore.IMultiplescoreEmpRangeService;

/**
 * Created by dtkj_android on 2017/6/6.
 */
@Service
public class MultiplescoreEmpRangeServiceImpl extends ServiceImpl<MultiplescoreEmpRangeMapper, MultiplescoreEmpRange> implements IMultiplescoreEmpRangeService {
    @Override
    public int updateEmpRanges(String[] empIds, Long empId, String enterpriseId) {
        int result = 0;
        // 删除旧记录
        baseMapper.delete(new EntityWrapper<MultiplescoreEmpRange>().eq("higherId", empId).eq("enterpriseId", enterpriseId));
        // 增加新记录
        if (null != empIds) {
            for (String lowerId : empIds) {
                if (StringUtils.isBlank(lowerId)) {
                    continue;
                }
                MultiplescoreEmpRange multiplescoreEmpRange = new MultiplescoreEmpRange();
                multiplescoreEmpRange.setHigherId(empId);
                multiplescoreEmpRange.setLowerId(NumberUtils.toLong(lowerId));
                multiplescoreEmpRange.setEnterpriseId(NumberUtils.toLong(enterpriseId));
                result = baseMapper.insert(multiplescoreEmpRange);
            }
        }
        return result;
    }
}
