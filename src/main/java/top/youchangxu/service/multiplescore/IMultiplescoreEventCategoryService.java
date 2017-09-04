package top.youchangxu.service.multiplescore;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescoreEventCategory;

/**
 * Created by dtkj_android on 2017/6/9.
 */
public interface IMultiplescoreEventCategoryService extends IService<MultiplescoreEventCategory>{

    JSONArray getBootstrapTreeData(String enterpriseId);
}
