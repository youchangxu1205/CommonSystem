package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.MultiplescoreRangeMapper;
import top.youchangxu.model.system.MultiplescoreRange;
import top.youchangxu.model.vo.PostRangeVO;
import top.youchangxu.service.system.IMultiplesoreRangeService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Service
public class MultiplescoreRangeServiceImpl extends ServiceImpl<MultiplescoreRangeMapper, MultiplescoreRange> implements IMultiplesoreRangeService {
    @Override
    public List<PostRangeVO> selectPostRangeVOS(Long postId) {

        return baseMapper.selectPostRangeVOS(postId);
    }
}
