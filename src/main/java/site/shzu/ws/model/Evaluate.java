package site.shzu.ws.model;

public class Evaluate {
    private Integer id;

    private Integer jobContractId;

    private String evainfo;

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

    public String getEvainfo() {
        return evainfo;
    }

    public void setEvainfo(String evainfo) {
        this.evainfo = evainfo == null ? null : evainfo.trim();
    }
}