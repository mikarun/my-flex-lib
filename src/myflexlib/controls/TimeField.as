package myflexlib.controls
{
  import flash.events.Event;
  import mx.core.IDataRenderer;
  import mx.events.FlexEvent;
  import mx.utils.ObjectUtil;
  
  import spark.components.NumericStepper;
  import spark.components.supportClasses.SkinnableComponent;
  
  
  //--------------------------------------
  //  Events
  //--------------------------------------

  /**
   *  Dispatched when the <code>data</code> property changes.
   *
   *  <p>When you use a component as an item renderer,
   *  the <code>data</code> property contains the data to display.
   *  You can listen for this event and update the component
   *  when the <code>data</code> property changes.</p>
   * 
   *  @eventType mx.events.FlexEvent.DATA_CHANGE
   *  
   *  @langversion 3.0
   *  @playerversion Flash 9
   *  @playerversion AIR 1.1
   *  @productversion Flex 3
   */
  [Event(name="dataChange", type="mx.events.FlexEvent")]
  
  /**
   *  The TimeField control is made of two numeric steper field used to 
   *  select a time.
   *  
   *  The data of the TimeField is a date by default current date   
   *   
   */ 
  public class TimeField extends SkinnableComponent implements IDataRenderer
  {
    public function TimeField()
    {
      super();
    }
    
    //----------------------------------
    //  data
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the data property
     */
    private var _data:Object;
    
    [Bindable("dataChange")]
    [Inspectable(environment="none")]
    
    /**
     *  The <code>data</code> property lets you pass a value
     *  to the component when you use it in an item renderer or item editor.
     *  You typically use data binding to bind a field of the <code>data</code>
     *  property to a property of this component.
     *
     *  <p>When you use the control as a drop-in item renderer or drop-in
     *  item editor, Flex automatically writes the current value of the item
     *  to the <code>selectedDate</code> property of this control.</p>
     *
     *  @default null
     *  @see mx.core.IDataRenderer
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get data():Object
    {
      return _data;
    }
    
    /**
     *  @private
     */
    public function set data(value:Object):void
    {    
      var newDate:Date;
      if (value is String)
        newDate = new Date(Date.parse(value as String));
      else if (value is Date)
        newDate = value as Date;
      
      if (ObjectUtil.dateCompare(_data as Date, newDate) == 0) 
        return;
      
      _data = newDate;
                 
      dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
    }
    
    
    //----------------------------------
    //  hour
    //----------------------------------
    /**
     *  @private
     */
    private var hourChanged:Boolean = false;
    /**
     * @private
     *  storage for the hour property 
     */ 
    private var _hour:Number= 0;
    
    private function get hour():Number{
      return _hour;
    }
    
    private function set hour(value:Number):void{
      if(_hour == value)
        return
      _hour = value;
      hourChanged = true;
      invalidateProperties();
    }
    
    //----------------------------------
    //  minute
    //----------------------------------
    /**
     *  @private
     */
    private var minuteChanged:Boolean = false;
    /**
     * @private
     *  storage for the minute property 
     */ 
    private var _minute:Number = 0;
    
    private function get minute():Number{
      return _minute;
    }
    
    private function set minute(value:Number):void{
      if(_minute == value)
        return
      _minute = value;
      minuteChanged = true;
      invalidateProperties();
    }
    
    //----------------------------------
    //  hourStepper
    //---------------------------------- 
    
    [SkinPart(required="false")]
    
    /**
     *  The skin part that defines the appearance of the 
     *  action bar area of the container.
     *  By default, the ActionsTileBarPanelSkin class defines the action bar area to appear on the  
     *  left of the title of the Panel container with a grey background. 
     *
     *  @see skins.containers.ActionsTitleBarPanelSkin
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var hourStepper:NumericStepper;
    
    //----------------------------------
    //  minuteStepper
    //---------------------------------- 
    
    [SkinPart(required="false")]
    
    /**
     *  The skin part that defines the appearance of the 
     *  action bar area of the container.
     *  By default, the ActionsTileBarPanelSkin class defines the action bar area to appear on the  
     *  left of the title of the Panel container with a grey background. 
     *
     *  @see skins.containers.ActionsTitleBarPanelSkin
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var minuteStepper:NumericStepper;
    
    
    /**
     *  @private
     */
    override protected function partAdded(partName:String, instance:Object):void
    {
      super.partAdded(partName, instance);
      
      if(instance == hourStepper){
        hourStepper.minimum = 0;
        hourStepper.maximum = 23;
        hourStepper.stepSize = 1;
        
        hourStepper.addEventListener(Event.CHANGE,hourStepper_changeHandler);        
      }
      
      if(instance == minuteStepper){
        minuteStepper.minimum = 0;
        minuteStepper.maximum = 59;
        minuteStepper.stepSize = 1;        
        
        minuteStepper.addEventListener(Event.CHANGE,minuteStepper_changeHandler);        
      }
      
    }
    
    /**
     *  @private
     */
    override protected function partRemoved(partName:String, instance:Object):void
    {      
      super.partRemoved(partName, instance);
      if(instance == hourStepper)
        hourStepper.removeEventListener(Event.CHANGE,hourStepper_changeHandler);        
      
      
      if(instance == minuteStepper)
        minuteStepper.removeEventListener(Event.CHANGE,minuteStepper_changeHandler);        
       
    }
    
    
    /**
     *  @private
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    override protected function getCurrentSkinState():String
    {
      return enabled ? "normal" : "disabled";
    }
    
    /**
     *  @private
     */
    override protected function commitProperties():void
    {   
      super.commitProperties();
      if(hourChanged){
        hourStepper.value = hour;
      }
      if(minuteChanged){
        minuteStepper.value = minute;
      }
    }
    
    
    /**
     *  @protected
     *  Handle a change on the hour stepper. 
     * the hour field is updated
     */
    protected function hourStepper_changeHandler(event:Event):void
    {
      var newHour:Number = hourStepper.value;
                  
      if (hour != newHour){
        hour = newHour; 
        commitTime();
      }
    }
    
    /**
     *  @protected
     *  Handle a change on the hour stepper. 
     * the minute field is updated
     */
    protected function minuteStepper_changeHandler(event:Event):void
    {
      var newMinute:Number = minuteStepper.value;
      
      if (minute != newMinute){
        minute = newMinute;
        commitTime();
      }
    }
    
    /**
     * Update the data property with the selected hour and minutes
     */  
    protected function commitTime():void{
      var newDate:Date;
      if(data == null)
        newDate = new Date();
      else
        newDate = data.clone();
      
      newDate.hours = hour;
      newDate.minutes = minute;
      data = newDate;
    }
  }
}