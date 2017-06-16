package top.youchangxu.easemob.api.impl;

import io.swagger.client.ApiException;
import io.swagger.client.api.UploadAndDownloadFilesApi;
import top.youchangxu.easemob.api.FileAPI;
import top.youchangxu.easemob.comm.EasemobAPI;
import top.youchangxu.easemob.comm.OrgInfo;
import top.youchangxu.easemob.comm.ResponseHandler;
import top.youchangxu.easemob.comm.TokenUtil;

import java.io.File;


public class EasemobFile implements FileAPI {
    private ResponseHandler responseHandler = new ResponseHandler();
    private UploadAndDownloadFilesApi api = new UploadAndDownloadFilesApi();

    @Override
    public Object uploadFile(final Object file) {
        return responseHandler.handle(new EasemobAPI() {
            @Override
            public Object invokeEasemobAPI() throws ApiException {
                return api.orgNameAppNameChatfilesPost(OrgInfo.ORG_NAME, OrgInfo.APP_NAME, TokenUtil.getAccessToken(), (File) file, true);
            }
        });
    }

    @Override
    public Object downloadFile(final String fileUUID, final String shareSecret, final Boolean isThumbnail) {
        return responseHandler.handle(new EasemobAPI() {
            @Override
            public Object invokeEasemobAPI() throws ApiException {
                return api.orgNameAppNameChatfilesUuidGet(OrgInfo.ORG_NAME, OrgInfo.APP_NAME, TokenUtil.getAccessToken(), fileUUID, shareSecret, isThumbnail);
            }
        });
    }
}
