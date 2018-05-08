package site.shzu.ws.model;

import java.util.Date;

public class Evaluate {
    private Integer id;

    private Integer jobContractId;

    private String sxpd;

    private String jyjs;

    private String gztd;

    private String gznl;

    private String xzjs;

    private String zhsz;

    private String evainfo;

    private String evaluater;

    private Date evaluateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getJobContractId() {
        return jobContractId;
    }

    public void setJobContractId(Integer jobContractId) {
        this.jobContractId = jobContractId;
    }

    public String getSxpd() {
        return sxpd;
    }

    public void setSxpd(String sxpd) {
        this.sxpd = sxpd == null ? null : sxpd.trim();
    }

    public String getJyjs() {
        return jyjs;
    }

    public void setJyjs(String jyjs) {
        this.jyjs = jyjs == null ? null : jyjs.trim();
    }

    public String getGztd() {
        return gztd;
    }

    public void setGztd(String gztd) {
        this.gztd = gztd == null ? null : gztd.trim();
    }

    public String getGznl() {
        return gznl;
    }

    public void setGznl(String gznl) {
        this.gznl = gznl == null ? null : gznl.trim();
    }

    public String getXzjs() {
        return xzjs;
    }

    public void setXzjs(String xzjs) {
        this.xzjs = xzjs == null ? null : xzjs.trim();
    }

    public String getZhsz() {
        return zhsz;
    }

    public void setZhsz(String zhsz) {
        this.zhsz = zhsz == null ? null : zhsz.trim();
    }

    public String getEvainfo() {
        return evainfo;
    }

    public void setEvainfo(String evainfo) {
        this.evainfo = evainfo == null ? null : evainfo.trim();
    }

    public String getEvaluater() {
        return evaluater;
    }

    public void setEvaluater(String evaluater) {
        this.evaluater = evaluater == null ? null : evaluater.trim();
    }

    public Date getEvaluateTime() {
        return evaluateTime;
    }

    public void setEvaluateTime(Date evaluateTime) {
        this.evaluateTime = evaluateTime;
    }
}