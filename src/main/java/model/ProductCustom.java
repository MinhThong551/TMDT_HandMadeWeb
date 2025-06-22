package model;

public class ProductCustom {
    private String productType;
    private int quantity;
    private String strapColor;
    private String bodyColor;
    private String flowerColor;
    private String bearBodyColor;
    private String bearNoseColor;
    private String bearRibbonColor;
    private String ribbonPosition;

    // Constructors
    public ProductCustom() {}

    public ProductCustom(String productType, int quantity, String strapColor, String bodyColor, String flowerColor,
                         String bearBodyColor, String bearNoseColor, String bearRibbonColor, String ribbonPosition) {
        this.productType = productType;
        this.quantity = quantity;
        this.strapColor = strapColor;
        this.bodyColor = bodyColor;
        this.flowerColor = flowerColor;
        this.bearBodyColor = bearBodyColor;
        this.bearNoseColor = bearNoseColor;
        this.bearRibbonColor = bearRibbonColor;
        this.ribbonPosition = ribbonPosition;
    }

    // Getters and Setters
    public String getProductType() { return productType; }
    public void setProductType(String productType) { this.productType = productType; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getStrapColor() { return strapColor; }
    public void setStrapColor(String strapColor) { this.strapColor = strapColor; }
    public String getBodyColor() { return bodyColor; }
    public void setBodyColor(String bodyColor) { this.bodyColor = bodyColor; }
    public String getFlowerColor() { return flowerColor; }
    public void setFlowerColor(String flowerColor) { this.flowerColor = flowerColor; }
    public String getBearBodyColor() { return bearBodyColor; }
    public void setBearBodyColor(String bearBodyColor) { this.bearBodyColor = bearBodyColor; }
    public String getBearNoseColor() { return bearNoseColor; }
    public void setBearNoseColor(String bearNoseColor) { this.bearNoseColor = bearNoseColor; }
    public String getBearRibbonColor() { return bearRibbonColor; }
    public void setBearRibbonColor(String bearRibbonColor) { this.bearRibbonColor = bearRibbonColor; }
    public String getRibbonPosition() { return ribbonPosition; }
    public void setRibbonPosition(String ribbonPosition) { this.ribbonPosition = ribbonPosition; }
}