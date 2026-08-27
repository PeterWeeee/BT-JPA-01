package vn.iotstar.models;

import java.io.Serializable;

public class CategoryModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String icon;

    public CategoryModel() {
        super();
    }

    public CategoryModel(int id, String name, String icon) {
        super();
        this.id = id;
        this.name = name;
        this.icon = icon;
    }

    public CategoryModel(String name, String icon) {
        super();
        this.name = name;
        this.icon = icon;
    }

    // Standard Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    // Helper Aliases (tương thích cả cateid / catename / icons theo slide)
    public int getCateid() {
        return id;
    }

    public void setCateid(int cateid) {
        this.id = cateid;
    }

    public String getCatename() {
        return name;
    }

    public void setCatename(String catename) {
        this.name = catename;
    }

    public String getIcons() {
        return icon;
    }

    public void setIcons(String icons) {
        this.icon = icons;
    }

    @Override
    public String toString() {
        return "CategoryModel [id=" + id + ", name=" + name + ", icon=" + icon + "]";
    }
}
