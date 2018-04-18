package site.shzu.ws.model;

public class EmpDep {
    private Integer id;

    private String depName;

    private String depInfo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName == null ? null : depName.trim();
    }

    public String getDepInfo() {
        return depInfo;
    }

    public void setDepInfo(String depInfo) {
        this.depInfo = depInfo == null ? null : depInfo.trim();
    }
}