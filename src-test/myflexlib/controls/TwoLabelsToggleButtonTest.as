package myflexlib.controls
{
  import org.flexunit.Assert;
  
  
  public class TwoLabelsToggleButtonTest
  {
    // Reference declaration for class to test
    private var button : TwoLabelsToggleButton;
    
    private static const SELECTED_LBL:String = "SELECTED LABEL";
    private static const UNSELECTED_LBL:String = "UNSELECTED LABEL";
        
    
    public function TwoLabelsToggleButtonTest()
    {
    }
    
    [Before]
    public function before():void{
      button = new TwoLabelsToggleButton();
      button.selectedLabel = SELECTED_LBL;
      button.unselectedLabel = UNSELECTED_LBL;
    }
        
    [Test]
    public function testDefaultLabelIsSelectedLabel():void
    {            
      Assert.assertFalse(button.selected);
      Assert.assertEquals(UNSELECTED_LBL,button.label)     
    }
    
    [Test]
    public function testLabelMethodOverriden():void
    {            
      Assert.assertFalse(button.selected);
      button.label = "label set with label method call"
      Assert.assertEquals(UNSELECTED_LBL,button.label);
      
    }
    
    [Test]
    public function testLabelChangeIfButtonSelected():void
    {          
      Assert.assertEquals(UNSELECTED_LBL,button.label)
      Assert.assertFalse(button.selected);
      button.selected = true;
      Assert.assertEquals(SELECTED_LBL,button.label)
      
    }
  }
}