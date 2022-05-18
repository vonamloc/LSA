using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

public class LessonBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;


    public int Create(Lesson obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addLesson", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LessonType", obj.LessonType);
            sqlCmd.Parameters.AddWithValue("@ModuleCode", obj.ModuleCode);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp1", obj.ModuleGrp1);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp2", obj.ModuleGrp2);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp3", obj.ModuleGrp3);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp4", obj.ModuleGrp4);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp5", obj.ModuleGrp5);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp6", obj.ModuleGrp6);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp7", obj.ModuleGrp7);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp8", obj.ModuleGrp8);
            sqlCmd.Parameters.AddWithValue("@TIC1", obj.TIC1);
            sqlCmd.Parameters.AddWithValue("@TIC2", obj.TIC2);
            sqlCmd.Parameters.AddWithValue("@TIC3", obj.TIC3);
            sqlCmd.Parameters.AddWithValue("@TIC4", obj.TIC4);
            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@DayOfWeek", obj.DayOfWeek);
            sqlCmd.Parameters.AddWithValue("@ELearnEvenWeek", obj.ELearnEvenWeek);
            sqlCmd.Parameters.AddWithValue("@TimeStart", obj.TimeStart);
            sqlCmd.Parameters.AddWithValue("@TimeEnd", obj.TimeEnd);
            sqlCmd.Parameters.AddWithValue("@WeekStart", obj.WeekStart);
            sqlCmd.Parameters.AddWithValue("@WeekEnd", obj.WeekEnd);
            sqlCmd.Parameters.AddWithValue("@Semester", obj.Semester);
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

    public int Update(Lesson obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updLesson", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LessonID", obj.LessonID);
            sqlCmd.Parameters.AddWithValue("@LessonType", obj.LessonType);
            sqlCmd.Parameters.AddWithValue("@ModuleCode", obj.ModuleCode);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp1", obj.ModuleGrp1);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp2", obj.ModuleGrp2);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp3", obj.ModuleGrp3);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp4", obj.ModuleGrp4);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp5", obj.ModuleGrp5);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp6", obj.ModuleGrp6);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp7", obj.ModuleGrp7);
            sqlCmd.Parameters.AddWithValue("@ModuleGrp8", obj.ModuleGrp8);
            sqlCmd.Parameters.AddWithValue("@TIC1", obj.TIC1);
            sqlCmd.Parameters.AddWithValue("@TIC2", obj.TIC2);
            sqlCmd.Parameters.AddWithValue("@TIC3", obj.TIC3);
            sqlCmd.Parameters.AddWithValue("@TIC4", obj.TIC4);
            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@DayOfWeek", obj.DayOfWeek);
            sqlCmd.Parameters.AddWithValue("@ELearnEvenWeek", obj.ELearnEvenWeek);
            sqlCmd.Parameters.AddWithValue("@TimeStart", obj.TimeStart);
            sqlCmd.Parameters.AddWithValue("@TimeEnd", obj.TimeEnd);
            sqlCmd.Parameters.AddWithValue("@WeekStart", obj.WeekStart);
            sqlCmd.Parameters.AddWithValue("@WeekEnd", obj.WeekEnd);
            sqlCmd.Parameters.AddWithValue("@Semester", obj.Semester);
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

    public int Delete(int lessonid)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delLesson", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LessonID", lessonid);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
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

    public List<Lesson> Retrieve()
    {
        List<Lesson> result = GetData();
        return result;
    }

    public Lesson SelectByLessonID(int lessonid)
    {
        Lesson result = Retrieve().Where(obj => obj.LessonID.Equals(lessonid)).FirstOrDefault();
        return result;
    }

    public List<Lesson> SelectByFacilityID(string faciid)
    {
        List<Lesson> result = Retrieve().Where(obj => obj.FacilityID.Equals(faciid)).ToList();
        return result;
    }

    public List<Lesson> SelectDistinctModulesByFacilityID(string faciid)
    {
        List<Lesson> result = new List<Lesson>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT DISTINCT ModuleCode FROM Lesson WHERE FacilityID = '{faciid}'";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Lesson obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "SelectDistinctModulesByFacilityID", e.Message);
        }

        return result;
    }

    protected List<Lesson> GetData()
    {
        List<Lesson> result = new List<Lesson>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM Lesson";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Lesson obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Lesson ToObj(DataRow row)
    {
        Lesson obj = null;
        try
        {
            int lessonid = row.Table.Columns.Contains("LessonID") ? CommonBL.IntegerMapper(row["LessonID"].ToString()) : 0;
            string lessontype = row.Table.Columns.Contains("LessonType") ? CommonBL.StringMapper(row["LessonType"]) : "";
            string modcode = row.Table.Columns.Contains("ModuleCode") ? CommonBL.StringMapper(row["ModuleCode"]) : "";
            string modgrp1 = row.Table.Columns.Contains("ModuleGrp1") ? CommonBL.StringMapper(row["ModuleGrp1"]) : "";
            string modgrp2 = row.Table.Columns.Contains("ModuleGrp2") ? CommonBL.StringMapper(row["ModuleGrp2"]) : "";
            string modgrp3 = row.Table.Columns.Contains("ModuleGrp3") ? CommonBL.StringMapper(row["ModuleGrp3"]) : "";
            string modgrp4 = row.Table.Columns.Contains("ModuleGrp4") ? CommonBL.StringMapper(row["ModuleGrp4"]) : "";
            string modgrp5 = row.Table.Columns.Contains("ModuleGrp5") ? CommonBL.StringMapper(row["ModuleGrp5"]) : "";
            string modgrp6 = row.Table.Columns.Contains("ModuleGrp6") ? CommonBL.StringMapper(row["ModuleGrp6"]) : "";
            string modgrp7 = row.Table.Columns.Contains("ModuleGrp7") ? CommonBL.StringMapper(row["ModuleGrp7"]) : "";
            string modgrp8 = row.Table.Columns.Contains("ModuleGrp8") ? CommonBL.StringMapper(row["ModuleGrp8"]) : "";
            string tic1 = row.Table.Columns.Contains("TIC1") ? CommonBL.StringMapper(row["TIC1"]) : "";
            string tic2 = row.Table.Columns.Contains("TIC2") ? CommonBL.StringMapper(row["TIC2"]) : "";
            string tic3 = row.Table.Columns.Contains("TIC3") ? CommonBL.StringMapper(row["TIC3"]) : "";
            string tic4 = row.Table.Columns.Contains("TIC4") ? CommonBL.StringMapper(row["TIC4"]) : "";
            string faciid = row.Table.Columns.Contains("FacilityID") ? CommonBL.StringMapper(row["FacilityID"]) : "";
            string dayofweek = row.Table.Columns.Contains("DayOfWeek") ? CommonBL.StringMapper(row["DayOfWeek"]) : "";
            bool elearnevenWk = row.Table.Columns.Contains("ELearnEvenWeek") && CommonBL.BoolMapper(row["ELearnEvenWeek"].ToString());
            DateTime tStart = row.Table.Columns.Contains("TimeStart") ? CommonBL.DateTimeMapper(row["TimeStart"].ToString()) : new DateTime();
            DateTime tEnd = row.Table.Columns.Contains("TimeEnd") ? CommonBL.DateTimeMapper(row["TimeEnd"].ToString()) : new DateTime();
            int wkStart = row.Table.Columns.Contains("WeekStart") ? CommonBL.IntegerMapper(row["WeekStart"].ToString()) : 0;
            int wkEnd = row.Table.Columns.Contains("WeekEnd") ? CommonBL.IntegerMapper(row["WeekEnd"].ToString()) : 0;
            string semester = row.Table.Columns.Contains("Semester") ? CommonBL.StringMapper(row["Semester"]) : "";
            string cBy = row.Table.Columns.Contains("CreateBy") ? CommonBL.StringMapper(row["CreateBy"]) : "";
            DateTime cDate = row.Table.Columns.Contains("CreateDate") ? CommonBL.DateTimeMapper(row["CreateDate"].ToString()) : new DateTime();
            string aBy = row.Table.Columns.Contains("AmendBy") ? CommonBL.StringMapper(row["AmendBy"]) : "";
            DateTime aDate = row.Table.Columns.Contains("AmendBy") ? CommonBL.DateTimeMapper(row["AmendBy"].ToString()) : new DateTime();

            obj = new Lesson(lessonid, lessontype, modcode, modgrp1, modgrp2, modgrp3, modgrp4, modgrp5, modgrp6, modgrp7, modgrp8, tic1, tic2, tic3, tic4, faciid, dayofweek, elearnevenWk, tStart, tEnd, wkStart, wkEnd, semester, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    public string Validate(Lesson ValObj)
    {
        StringBuilder errorMsg = new StringBuilder();
        //At least one PEM Grp needs to attend the lesson
        if (string.IsNullOrEmpty(ValObj.ModuleGrp1))
            errorMsg.Append("Please complete all fields.<br/>");

        if (DateTime.Compare(ValObj.TimeStart, ValObj.TimeEnd) >= 0)
            errorMsg.Append("Time End needs to be later than Time Start.<br/>");

        return errorMsg.ToString();
    }
}