package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.MultiplescoreRangeMapper;
import top.youchangxu.model.system.MultiplescorePostRange;
import top.youchangxu.model.vo.PostRangeVO;
import top.youchangxu.service.system.IMultiplesoreRangeService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Service
public class MultiplescoreRangeServiceImpl extends ServiceImpl<MultiplescoreRangeMapper, MultiplescorePostRange> implements IMultiplesoreRangeService {
    @Override
    public List<PostRangeVO> selectPostRangeVOS(Long postId) {

        return baseMapper.selectPostRangeVOS(postId);
    }

    @Override
    public List<PostRangeVO> selectPostNoRangeVOS(Long postId) {
        return baseMapper.selectPostNoRangeVOS(postId);
    }

    @Override
    public boolean updateRanges(List<MultiplescorePostRange> multiplescorePostRanges, Long postId, Long enterpriseId) {
        baseMapper.delete(new EntityWrapper<MultiplescorePostRange>().eq("postHigherId", postId).eq("enterpriseId", enterpriseId));
        if (multiplescorePostRanges.size() != 0) {
            return insertBatch(multiplescorePostRanges);
        }
        return true;
    }
}
