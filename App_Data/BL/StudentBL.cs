using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class StudentBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(Student obj)
    {
        int result = 1;

        SqlConnection sqlConn = new SqlConnection(DBConnect);
        SqlCommand sqlCmd = new SqlCommand("addStudent", sqlConn)
        {
            CommandType = CommandType.StoredProcedure
        };
        try
        {
            sqlCmd.Parameters.AddWithValue("@AdminNo", obj.AdminNo);
            sqlCmd.Parameters.AddWithValue("@PEMGrp", obj.PEMGrp);
            sqlCmd.Parameters.AddWithValue("@Course", obj.Course);
            sqlCmd.Parameters.AddWithValue("@Age", obj.Age);
            sqlCmd.Parameters.AddWithValue("@Gender", obj.Gender);
            sqlCmd.Parameters.AddWithValue("@GPAS1", obj.GPAS1);
            sqlCmd.Parameters.AddWithValue("@GPAS2", obj.GPAS2);
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

    public int Update(Student obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updStudent", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@StudentID", obj.StudentID);
            sqlCmd.Parameters.AddWithValue("@AdminNo", obj.AdminNo);
            sqlCmd.Parameters.AddWithValue("@PEMGrp", obj.PEMGrp);
            sqlCmd.Parameters.AddWithValue("@Course", obj.Course);
            sqlCmd.Parameters.AddWithValue("@Age", obj.Age);
            sqlCmd.Parameters.AddWithValue("@Gender", obj.Gender);
            sqlCmd.Parameters.AddWithValue("@GPAS1", obj.GPAS1);
            sqlCmd.Parameters.AddWithValue("@GPAS2", obj.GPAS2);
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

    public int Delete(Student obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delStudent", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@StudentID", obj.StudentID);
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

    public List<Student> Retrieve()
    {
        List<Student> result = GetData();
        return result;
    }

    protected List<Student> GetData()
    {
        List<Student> result = new List<Student>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM Student";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Student obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Student ToObj(DataRow row)
    {
        Student obj = null;
        try
        {
            int studentid = CommonBL.IntegerMapper(row["StudentID"].ToString());
            string admno = CommonBL.StringMapper(row["AdminNo"]);
            string pemgrp = CommonBL.StringMapper(row["PEMGrp"]);
            string crs = CommonBL.StringMapper(row["Course"]);
            int age = CommonBL.IntegerMapper(row["Age"].ToString());
            string gedr = CommonBL.StringMapper(row["Gender"]);
            float gpas1 = CommonBL.FloatMapper(row["GPAS1"].ToString());
            float gpas2 = CommonBL.FloatMapper(row["GPAS2"].ToString());
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new Student(studentid, admno, pemgrp, crs, age, gedr, gpas1, gpas2, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }
}