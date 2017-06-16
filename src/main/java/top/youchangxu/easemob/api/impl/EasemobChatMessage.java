package top.youchangxu.easemob.api.impl;

import io.swagger.client.ApiException;
import io.swagger.client.api.ChatHistoryApi;
import top.youchangxu.easemob.api.ChatMessageAPI;
import top.youchangxu.easemob.comm.EasemobAPI;
import top.youchangxu.easemob.comm.OrgInfo;
import top.youchangxu.easemob.comm.ResponseHandler;
import top.youchangxu.easemob.comm.TokenUtil;


public class EasemobChatMessage  implements ChatMessageAPI {

    private ResponseHandler responseHandler = new ResponseHandler();
    private ChatHistoryApi api = new ChatHistoryApi();

    @Override
    public Object exportChatMessages(final Long limit,final String cursor,final String query) {
        return responseHandler.handle(new EasemobAPI() {
            @Override
            public Object invokeEasemobAPI() throws ApiException {
                return api.orgNameAppNameChatmessagesGet(OrgInfo.ORG_NAME,OrgInfo.APP_NAME, TokenUtil.getAccessToken(),query,limit+"",cursor);
            }
        });
    }
}
