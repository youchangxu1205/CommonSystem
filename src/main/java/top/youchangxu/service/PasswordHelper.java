package top.youchangxu.service;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import top.youchangxu.model.system.StaffingEmp;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Service
public class PasswordHelper {

    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();

    private String algorithmName = "md5";
    private int hashIterations = 2;

    public void setRandomNumberGenerator(RandomNumberGenerator randomNumberGenerator) {
        this.randomNumberGenerator = randomNumberGenerator;
    }

    public void setAlgorithmName(String algorithmName) {
        this.algorithmName = algorithmName;
    }

    public void setHashIterations(int hashIterations) {
        this.hashIterations = hashIterations;
    }

    public void encryptPassword(StaffingEmp staffingEmp) {

        staffingEmp.setSalt(randomNumberGenerator.nextBytes().toHex());

        String newPassword = new SimpleHash(
                algorithmName,
                staffingEmp.getPassword(),
                ByteSource.Util.bytes(staffingEmp.getCredentialsSalt()),
                hashIterations).toHex();

        staffingEmp.setPassword(newPassword);
    }

    public boolean compilePassword(String password,StaffingEmp staffingEmp){
        String newPassword = new SimpleHash(
                algorithmName,
                password,
                ByteSource.Util.bytes(staffingEmp.getCredentialsSalt()),
                hashIterations).toHex();

        return newPassword.equals(staffingEmp.getPassword());
    }
}
