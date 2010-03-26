package myflexlib.controls
{
  import flash.events.Event;
  import mx.binding.utils.ChangeWatcher;
  
  import spark.components.ToggleButton;
  
  /**
   * This class defined a ToggleButton displaying two titles depending on the
   * state (selected or not) of the button
   */  
  public class TwoLabelsToggleButton extends ToggleButton
  {
    public function TwoLabelsToggleButton()
    {
      super();
      super.label = unselectedLabel;
      ChangeWatcher.watch(this,"selected",updateLabel);
    }
        
    
    //--------------------------------------------------------------------------
    //
    //  Variables 
    //
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    //  selectedLabel 
    //--------------------------------------------------------------------------
    private var _selectedLabel:String = "";
    public function get selectedLabel():String{
      return _selectedLabel;
    }
    public function set selectedLabel(value:String):void{
      _selectedLabel = value;
      if(selected)
        super.label = _selectedLabel;
    }
  
    //--------------------------------------------------------------------------
    //  unselectedLabel 
    //--------------------------------------------------------------------------
    private var _unselectedLabel:String="";
    public function get unselectedLabel():String{
      return _unselectedLabel;
    }
    public function set unselectedLabel(value:String):void{
      _unselectedLabel = value;
      if(!selected)
        super.label = _unselectedLabel;
    }
    
    /**
     * Handler call when the selected propertie changed
     * This function is reponsible of changing the label button
     */  
    protected function updateLabel(event:Event):void{
      if(selected)
        super.label = selectedLabel;
      else
        super.label = unselectedLabel;
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  overriden methods 
    //
    //--------------------------------------------------------------------------
    
    override public function set label(value:String):void{
      //do nothing      
    }
  }
}