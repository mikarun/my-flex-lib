package myflexlib.controls
{
  import flash.events.Event;
  import mx.core.IDataRenderer;
  import mx.events.FlexEvent;
  import mx.formatters.NumberFormatter;
  
  import spark.components.Label;
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
    
    private var dataChanged:Boolean;
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
      if(value == null){
        newDate = new Date();
      }
      if (value is String)
        newDate = new Date(Date.parse(value as String));
      else if (value is Date)
        newDate = value as Date;   
      
      _data = newDate;
      dataChanged = true;
      invalidateProperties();                       
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
    }
    
    //----------------------------------
    //  separatorText
    //----------------------------------
    /**
     *  @private
     */
    public var separatorTextChanged:Boolean = false;
    /**
     * @private
     *  storage for the separatorText property 
     */ 
    private var _separatorText:String= "h";
    
    public function get separatorText():String{
      return _separatorText;
    }
    
    public function set separatorText(value:String):void{
      if(_separatorText == value)
        return
        _separatorText = value;
      separatorTextChanged = true;
      invalidateProperties();
    }
    
    //----------------------------------
    //  minimumHour
    //----------------------------------
    /**
     *  @private
     * minimumHour : step to use for the minutes
     */
    private var minimumHourChanged:Boolean = false;
    /**
     * @private
     *  storage for the minimumHour property 
     */ 
    private var _minimumHour:Number= 0;
    
    
    /**
     * MinutesSteps defines the step to use in the minuteStepper field
     * @default = 1
     */  
    public function get minimumHour():Number{
      return _minimumHour;
    }
    
    public function set minimumHour(value:Number):void{
      if(_minimumHour == value)
        return
        _minimumHour = value;
      minimumHourChanged = true;
      invalidateProperties();      
    }
    
    //----------------------------------
    //  maximumHour
    //----------------------------------
    /**
     *  @private
     * maximumHour : step to use for the minutes
     */
    private var maximumHourChanged:Boolean = false;
    /**
     * @private
     *  storage for the maximumHour property 
     */ 
    private var _maximumHour:Number= 23;
    
    
    /**
     * MinutesSteps defines the step to use in the minuteStepper field
     * @default = 1
     */  
    public function get maximumHour():Number{
      return _maximumHour;
    }
    
    public function set maximumHour(value:Number):void{
      if(_maximumHour == value)
        return
        _maximumHour = value;
      maximumHourChanged = true;
      invalidateProperties();      
    }
    
    //----------------------------------
    //  minutesStep
    //----------------------------------
    /**
     *  @private
     * minutesStepSize : step to use for the minutes
     */
    private var minutesStepSizeChanged:Boolean = false;
    /**
     * @private
     *  storage for the minutesStepSize property 
     */ 
    private var _minutesStepSize:Number= 1;
    
    
    /**
     * MinutesSteps defines the step to use in the minuteStepper field
     * @default = 1
     */  
    public function get minutesStepSize():Number{
      return _minutesStepSize;
    }
    
    public function set minutesStepSize(value:Number):void{
      if(_minutesStepSize == value)
        return
      _minutesStepSize = value;
      minutesStepSizeChanged = true;
      invalidateProperties();      
    }
    
    /**
     * default value Format function used to format number
     * numbers are formated with 2 char 0 => 00, 9=> 09
     */  
    private function hourMinutesFormatFunction(value:Number):String{
      var ret:String = "";
      if(isNaN(value))
        return ret      
      if(value < 10){
        ret +="0";
      }
      return ret+value.toString();
    }
    
    //----------------------------------
    //  hourStepper
    //---------------------------------- 
    
    [SkinPart(required="true")]
    
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
    
    [SkinPart(required="true")]
    
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
    
    //----------------------------------
    //  separator
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
    public var separator:Label;
    
    
    /**
     * Returns the maximum of the minuteStepper depending on
     * the stepSize selected
     * if stepSize = 1, maximum = 59
     * if stepSize = 15, maximum = 45
     * ...
     */  
    private function computeMinuteMaximum(stepSize:Number):Number{
      var maximum:Number = 0;
      if(stepSize > 0){
        // nbrTime stepSize in 60
        var nbrTimes:Number = Math.floor(60/stepSize);
        maximum = Math.max(0,(nbrTimes - 1)) * stepSize;        
      }      
      
      return maximum;
    }
    
    /**
     *  @private
     */
    override protected function partAdded(partName:String, instance:Object):void
    {
      super.partAdded(partName, instance);
      
      if(instance == hourStepper){
        hourStepper.minimum = minimumHour;
        hourStepper.maximum = maximumHour;
        hourStepper.stepSize = 1;        
        hourStepper.value = hour;
        hourStepper.maxChars = 2;
        hourStepper.allowValueWrap=true;
        hourStepper.valueFormatFunction = hourMinutesFormatFunction;
        hourStepper.addEventListener(Event.CHANGE,hourStepper_changeHandler);          
      }
      
      if(instance == minuteStepper){
        minuteStepper.minimum = 0;        
        minuteStepper.stepSize = minutesStepSize;
        minuteStepper.maximum = computeMinuteMaximum(minutesStepSize);
        minuteStepper.value = minute;
        minuteStepper.maxChars = 2;
        minuteStepper.allowValueWrap=true;
        minuteStepper.valueFormatFunction = hourMinutesFormatFunction;
        minuteStepper.addEventListener(Event.CHANGE,minuteStepper_changeHandler);        
      }
      
      if(instance == separator)
        separator.text = separatorText;      
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
    
    
    //----------------------------------
    //  baselinePosition
    //----------------------------------
    
    /**
     *  @private
     */
    override public function get baselinePosition():Number
    {
      return getBaselinePositionForPart(hourStepper);
    }
    
    /**
     *  @private
     */
    override protected function commitProperties():void
    {   
      super.commitProperties();
      
      if(minimumHourChanged){
        hourStepper.minimum = minimumHour;        
        minimumHourChanged = false;
      }
      
      if(maximumHourChanged){
        hourStepper.maximum = maximumHour;        
        maximumHourChanged = false;
      }
      
      if(minutesStepSizeChanged){
        minuteStepper.stepSize = minutesStepSize;
        minuteStepper.maximum = computeMinuteMaximum(minutesStepSize);
        minutesStepSizeChanged = false;
      }
      if(separatorTextChanged){
        separator.text = separatorText;
        separatorTextChanged = false;
      }
      if(dataChanged){
        hour = data.hours
        minute = data.minutes;  
        hourStepper.value = data.hours;
        minuteStepper.value = data.minutes;
        dataChanged = false;
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
      if(data == null){
        data = new Date();
        data.seconds = 0;
      }
      data.hours = hour;
      data.minutes = minute;      
      dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
      dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));     
    }
  }
}