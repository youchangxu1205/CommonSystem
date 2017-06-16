package top.youchangxu.easemob.api.impl;

import io.swagger.client.ApiException;
import io.swagger.client.api.MessagesApi;
import io.swagger.client.model.Msg;
import top.youchangxu.easemob.api.SendMessageAPI;
import top.youchangxu.easemob.comm.EasemobAPI;
import top.youchangxu.easemob.comm.OrgInfo;
import top.youchangxu.easemob.comm.ResponseHandler;
import top.youchangxu.easemob.comm.TokenUtil;

public class EasemobSendMessage implements SendMessageAPI {
    private ResponseHandler responseHandler = new ResponseHandler();
    private MessagesApi api = new MessagesApi();

    @Override
    public Object sendMessage(final Object payload) {
        return responseHandler.handle(new EasemobAPI() {
            @Override
            public Object invokeEasemobAPI() throws ApiException {
                return api.orgNameAppNameMessagesPost(OrgInfo.ORG_NAME, OrgInfo.APP_NAME, TokenUtil.getAccessToken(), (Msg) payload);
            }
        });
    }
}
