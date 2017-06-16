package top.youchangxu.easemob.api.impl;


import top.youchangxu.easemob.api.AuthTokenAPI;
import top.youchangxu.easemob.comm.TokenUtil;

public class EasemobAuthToken implements AuthTokenAPI {

	@Override
	public Object getAuthToken(){
		return TokenUtil.getAccessToken();
	}
}
