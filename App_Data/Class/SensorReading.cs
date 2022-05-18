using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class SensorReading
{
    public DateTime DateTimeStamp { get; set; }
    public float Sound { get; set; }
    public float Humidity { get; set; }
    public float Temperature { get; set; }
    public float Motion { get; set; }
    public string DeviceID { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }
    /*public object Motion { get; internal set; }*/

    public SensorReading()
    {

    }

    public SensorReading(DateTime dts, float sound, float hmd, float temp, float motion, string devid, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        DateTimeStamp = dts;
        Sound = sound;
        Humidity = hmd;
        Temperature = temp;
        Motion = motion;
        DeviceID = devid;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }

    public class API_CustomEntity
    {
        //Note: Some of these property names are based on Minut's API JSON response. DO NOT rename them as it will disrupt the logic when the response is deserialized.
        public DateTime Datetime { get; set; }
        public float Value { get; set; }
        [JsonIgnore]
        [JsonProperty(Required = Required.Default)]
        public string ReadingType { get; set; }


        public API_CustomEntity()
        {
            
        }

    }
}
