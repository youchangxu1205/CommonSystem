package top.youchangxu.service.multiplescore.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplescoreEventCategoryMapper;
import top.youchangxu.model.multiplescore.MultiplescoreEventCategory;
import top.youchangxu.service.multiplescore.IMultiplescoreEventCategoryService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/9.
 */
@Service("multiplescoreEventCategoryService")
public class MultiplescoreEventCategoryServiceImpl extends ServiceImpl<MultiplescoreEventCategoryMapper, MultiplescoreEventCategory> implements IMultiplescoreEventCategoryService {
    @Override
    public JSONArray getBootstrapTreeData(String enterpriseId) {
        EntityWrapper<MultiplescoreEventCategory> entityWrapper = new EntityWrapper<>();
        entityWrapper
                .eq("enterpriseId", enterpriseId);

        List<MultiplescoreEventCategory> multiplescoreEventCategories = baseMapper.selectList(entityWrapper);
        JSONArray childArray = new JSONArray();
        if (multiplescoreEventCategories.size() > 0) {
            for (MultiplescoreEventCategory multiplescoreEventCategory :
                    multiplescoreEventCategories) {
                JSONObject node = new JSONObject();
                node.put("id", multiplescoreEventCategory.getEventCategoryId());
                node.put("text", multiplescoreEventCategory.getEventCategoryName());
                childArray.add(node);
            }
        }
        return childArray;
    }
}
