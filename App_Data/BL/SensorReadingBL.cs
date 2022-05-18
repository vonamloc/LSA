using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class SensorReadingBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(SensorReading obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addSensorReading", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@DateTimeStamp", obj.DateTimeStamp);
            sqlCmd.Parameters.AddWithValue("@Sound", obj.Sound);
            sqlCmd.Parameters.AddWithValue("@Humidity", obj.Humidity);
            sqlCmd.Parameters.AddWithValue("@Temperature", obj.Temperature);
            sqlCmd.Parameters.AddWithValue("@Motion", obj.Motion);
            sqlCmd.Parameters.AddWithValue("@DeviceID", obj.DeviceID);
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

    public int Update(SensorReading obj)
    {
        throw new NotImplementedException();
    }
    
    public int Delete(SensorReading obj)
    {
        throw new NotImplementedException();
    }

    public List<SensorReading> Retrieve()
    {
        List<SensorReading> result = GetData();
        return result;
    }

    public float SelectAvgReadingByDeviceIDAndDateTimeStamp(string readingType, string devid, DateTime startDate, DateTime endDate, bool excludeOutliers)
    {
        //Note: excludeOutliers variable will alter the behaviour of average calculation
        float result = 0;

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT AVG({readingType}) AS {readingType} FROM SensorReading WHERE{(excludeOutliers == true ? " " + readingType + " != 0 AND " : " ")}DeviceID ='{devid}'"+
                $" AND DateTimeStamp BETWEEN CAST('{startDate:yyyy-MM-ddTHH:mm:ss}' AS DateTime) AND CAST('{endDate:yyyy-MM-ddTHH:mm:ss}' As DateTime)"+
                $" AND CAST(DateTimeStamp As Time) BETWEEN CAST('{startDate:HH:mm:ss}' AS Time) AND CAST('{endDate:HH:mm:ss}' As Time)"+
                " GROUP BY DeviceID";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                result = ToCustomObj(row, readingType);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "SelectAvgReadingByDeviceIDAndDateTimeStamp", e.Message);
        }

        return result;
    }

    public List<SensorReading> SelectByDeviceID(List<string> devid)
    {
        List<SensorReading> result = new List<SensorReading>();
        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT * FROM SensorReading WHERE DeviceID IN ('{string.Join("','", devid)}')";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                SensorReading ReadObj = ToObj(row);
                result.Add(ReadObj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "SelectByDeviceID", e.Message);
        }

        return result;
    }

    public List<SensorReading> SelectByProjectPhase(int ProjPhaseID)
    {
        ProjectPhaseBL PPBL = new ProjectPhaseBL();
        ProjectPhase phase = PPBL.SelectByProjPhaseID(ProjPhaseID);

        List<SensorReading> result = new List<SensorReading>();
        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT * FROM SensorReading WHERE DateTimeStamp BETWEEN CAST('{phase.StartDate:yyyy-MM-ddTHH:mm:ss}' AS DateTime) AND CAST('{phase.EndDate:yyyy-MM-ddTHH:mm:ss}' As DateTime)";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                SensorReading ReadObj = ToObj(row);
                result.Add(ReadObj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "SelectByDeviceID", e.Message);
        }

        return result;
    }

    public List<SensorReading> SelectByDeviceIDAndDateTimeStamp(string devid, DateTime startDT, DateTime endDT)
    {
        List<SensorReading> result = new List<SensorReading>();
        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT * FROM SensorReading WHERE DeviceID ='{devid}' AND DateTimeStamp BETWEEN CAST('{startDT:yyyy-MM-ddTHH:mm:ss}' AS DateTime) AND CAST('{endDT:yyyy-MM-ddTHH:mm:ss}' As DateTime)";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                SensorReading obj = ToObj(row);
                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "SelectByDeviceIDAndDateTimeStamp", e.Message);
        }

        return result;
    }

    protected List<SensorReading> GetData()
    {
        List<SensorReading> result = new List<SensorReading>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM SensorReading";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                SensorReading obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected SensorReading ToObj(DataRow row)
    {
        SensorReading obj = null;
        try
        {
            DateTime dts = CommonBL.DateTimeMapper(row["DateTimeStamp"].ToString());
            float sound = CommonBL.FloatMapper(row["Sound"].ToString());
            float hmd = CommonBL.FloatMapper(row["Humidity"].ToString());
            float temp = CommonBL.FloatMapper(row["Temperature"].ToString());
            float motion = CommonBL.FloatMapper(row["Motion"].ToString());
            string devid = CommonBL.StringMapper(row["DeviceID"]);
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new SensorReading(dts, sound, hmd, temp, motion, devid, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    protected float ToCustomObj(DataRow row, string readingType)
    {
        float obj = 0;
        try
        {
            obj = CommonBL.FloatMapper(row[$"{readingType}"].ToString());
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToCustomObj", e.Message);
        }

        return obj;
    }
}