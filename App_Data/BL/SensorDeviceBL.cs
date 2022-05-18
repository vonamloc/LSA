using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

public class SensorDeviceBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(SensorDevice obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addSensorDevice", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@DeviceID", obj.DeviceID);
            sqlCmd.Parameters.AddWithValue("@DeviceMAC", obj.DeviceMAC);
            sqlCmd.Parameters.AddWithValue("@DeviceName", obj.DeviceName);
            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@DevicePosition", obj.DevicePosition);
            sqlCmd.Parameters.AddWithValue("@FirstSeen", obj.FirstSeen);
            sqlCmd.Parameters.AddWithValue("@LastHeard", obj.LastHeard);
            sqlCmd.Parameters.AddWithValue("@LastHeartBeat", obj.LastHeartBeat);
            sqlCmd.Parameters.AddWithValue("@AlarmRecognition", obj.AlarmRecognition);
            sqlCmd.Parameters.AddWithValue("@PowerSaveMode", obj.PowerSaveMode);
            sqlCmd.Parameters.AddWithValue("@ListeningMode", obj.ListeningMode);  
            sqlCmd.Parameters.AddWithValue("@ActiveStatus", obj.ActiveStatus.ToString());  
            sqlCmd.Parameters.AddWithValue("@CreateBy", obj.CreateBy);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Create", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public int Update(SensorDevice obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updSensorDevice", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@DeviceID", obj.DeviceID);
            sqlCmd.Parameters.AddWithValue("@DeviceMAC", obj.DeviceMAC);
            sqlCmd.Parameters.AddWithValue("@DeviceName", obj.DeviceName);
            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@DevicePosition", obj.DevicePosition);
            sqlCmd.Parameters.AddWithValue("@FirstSeen", obj.FirstSeen);
            sqlCmd.Parameters.AddWithValue("@LastHeard", obj.LastHeard);
            sqlCmd.Parameters.AddWithValue("@LastHeartBeat", obj.LastHeartBeat);
            sqlCmd.Parameters.AddWithValue("@AlarmRecognition", obj.AlarmRecognition);
            sqlCmd.Parameters.AddWithValue("@PowerSaveMode", obj.PowerSaveMode);
            sqlCmd.Parameters.AddWithValue("@ListeningMode", obj.ListeningMode);
            sqlCmd.Parameters.AddWithValue("@ActiveStatus", obj.ActiveStatus.ToString());
            sqlCmd.Parameters.AddWithValue("@AmendBy", obj.AmendBy);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Update", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public int Delete(SensorDevice obj)
    {
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        int result = 1;
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delSensorDevice", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@DeviceID", obj.DeviceID);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value; sqlConn.Open();
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Delete", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public List<SensorDevice> Retrieve()
    {
        List<SensorDevice> result = GetData();
        return result;
    }

    public SensorDevice SelectByDeviceID(string devid)
    {
        SensorDevice result = Retrieve().Where(obj => obj.DeviceID.Equals(devid)).FirstOrDefault();
        return result;
    }

    public List<SensorDevice> SelectByFacilityID(string faciid)
    {
        List<SensorDevice> result = Retrieve().Where(obj => obj.FacilityID.Equals(faciid)).ToList();
        return result;
    }

    protected List<SensorDevice> GetData()
    {
        List<SensorDevice> result = new List<SensorDevice>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM SensorDevice";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                SensorDevice obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected SensorDevice ToObj(DataRow row)
    {
        SensorDevice obj = null;
        try
        {
            string devid = CommonBL.StringMapper(row["DeviceID"]);
            string devmac = CommonBL.StringMapper(row["DeviceMAC"]);
            string devname = CommonBL.StringMapper(row["DeviceName"]);
            string faciid = CommonBL.StringMapper(row["FacilityID"]);
            string devpos = CommonBL.StringMapper(row["DevicePosition"]);
            DateTime firstSeen = CommonBL.DateTimeMapper(row["FirstSeen"].ToString());
            DateTime lastHeard = CommonBL.DateTimeMapper(row["LastHeard"].ToString());
            DateTime lastHeartBeat = CommonBL.DateTimeMapper(row["LastHeartBeat"].ToString());
            string alarmrecog = CommonBL.StringMapper(row["AlarmRecognition"]);
            string powersavemode = CommonBL.StringMapper(row["PowerSaveMode"]);
            string listenmode = CommonBL.StringMapper(row["ListeningMode"]);
            bool activeStatus = CommonBL.BoolMapper(row["ActiveStatus"].ToString());
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new SensorDevice(devid, devmac, devname, faciid, devpos, firstSeen, lastHeard, lastHeartBeat, alarmrecog, powersavemode, listenmode, activeStatus, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }
}