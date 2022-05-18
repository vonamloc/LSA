using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class SensorDevice
{
    public string DeviceID { get; set; }
    public string DeviceMAC { get; set; }
    public string DeviceName { get; set; }
    public string FacilityID { get; set; }
    public string DevicePosition { get; set; }
    public DateTime FirstSeen { get; set; }
    public DateTime LastHeard { get; set; }
    public DateTime LastHeartBeat { get; set; }
    public string AlarmRecognition { get; set; }
    public string PowerSaveMode { get; set; }
    public string ListeningMode { get; set; }
    public bool ActiveStatus { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public SensorDevice()
    {

    }
    public SensorDevice(string devid, string devmac, string devname, string faciid, string devpos, DateTime firstSeen, DateTime lastHeard, DateTime lastHeartbeat, string alarmrecog, string powersavemode, string listenmode, bool activeStatus, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        DeviceID = devid;
        DeviceMAC = devmac;
        DeviceName = devname;
        FacilityID = faciid;
        DevicePosition = devpos;
        FirstSeen = firstSeen;
        LastHeard = lastHeard;
        LastHeartBeat = lastHeartbeat;
        AlarmRecognition = alarmrecog;
        PowerSaveMode = powersavemode;
        ListeningMode = listenmode;
        ActiveStatus = activeStatus;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }

    public class API_CustomEntity
    {
        public string Device_id { get; set; }
        public string Device_mac { get; set; }
        public string Owner { get; set; }
        public string Home { get; set; }
        public bool Active { get; set; }
        public bool Offline { get; set; }
        public string Report_Interval { get; set; }
        public string First_seen_at { get; set; }
        public string Last_heard_from_at { get; set; }
        public string Last_heartbeat_at { get; set; }
        public Dictionary<dynamic, dynamic> Firmware { get; set; }
        public int Hardware_version { get; set; }
        public string Description { get; set; }
        public string Nightlight_mode { get; set; }
        public string Nightlight_start_at { get; set; }
        public string Nightlight_end_at { get; set; }
        public string Muted_until { get; set; }
        public Dictionary<dynamic, dynamic> Configuration { get; set; }
        public List<dynamic> Ongoing_events { get; set; }
        public bool Hap_paired { get; set; }
        public bool Hap_mfi_provisioned { get; set; }
        public string Hap_setup_payload { get; set; }
        public string Alarm_recognition { get; set; }
        public string Power_saving_mode { get; set; }
        public Dictionary<dynamic, dynamic> Latest_sensor_values { get; set; }
        public Dictionary<dynamic, dynamic> Wlan { get; set; }
        public string Mount_status { get; set; }
        public string Mould_risk_level { get; set; }
        public Dictionary<dynamic, dynamic> Insights { get; set; }
        public string Charge_status { get; set; }
        public Dictionary<dynamic, dynamic> Battery { get; set; }
        public string Listening_mode { get; set; }
        public string Network_interface { get; set; }

        public API_CustomEntity()
        {

        }

    }
}