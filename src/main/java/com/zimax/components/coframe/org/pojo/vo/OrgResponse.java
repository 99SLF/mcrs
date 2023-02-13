package com.zimax.components.coframe.org.pojo.vo;

/**
 * @Author 施林丰
 * @Date:2023/2/11 14:12
 * @Description
 */
public class OrgResponse {
    //标识符，true:成功，false:失败
    private boolean flag;

    //提示信息
    private String message;

    public OrgResponse() {
        super();
    }

    public OrgResponse(String message) {
        super();
        this.message = message;
    }

    public OrgResponse(boolean flag) {
        super();
        this.flag = flag;
    }

    public OrgResponse(boolean flag, String message) {
        super();
        this.flag = flag;
        this.message = message;
    }

    public boolean getFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
