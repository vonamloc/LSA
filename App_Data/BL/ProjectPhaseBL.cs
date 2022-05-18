using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ProjectPhaseBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(ProjectPhase obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addProjectPhase", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ProjPhaseID", obj.ProjPhaseID);
            sqlCmd.Parameters.AddWithValue("@StartDate", obj.StartDate);
            sqlCmd.Parameters.AddWithValue("@EndDate", obj.EndDate);
            sqlCmd.Parameters.AddWithValue("@ProjectLead", obj.ProjectLead);
            sqlCmd.Parameters.AddWithValue("@Member2", obj.Member2);
            sqlCmd.Parameters.AddWithValue("@Member3", obj.Member3);
            sqlCmd.Parameters.AddWithValue("@Member4", obj.Member4);
            sqlCmd.Parameters.AddWithValue("@ProjectSupervisor", obj.ProjectSupervisor);
            sqlCmd.Parameters.AddWithValue("@CreateBy", obj.CreateBy);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value; sqlConn.Open();
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

    public int Update(ProjectPhase obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updProjectPhase", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ProjPhaseID", obj.ProjPhaseID);
            sqlCmd.Parameters.AddWithValue("@StartDate", obj.StartDate);
            sqlCmd.Parameters.AddWithValue("@EndDate", obj.EndDate);
            sqlCmd.Parameters.AddWithValue("@ProjectLead", obj.ProjectLead);
            sqlCmd.Parameters.AddWithValue("@Member2", obj.Member2);
            sqlCmd.Parameters.AddWithValue("@Member3", obj.Member3);
            sqlCmd.Parameters.AddWithValue("@Member4", obj.Member4);
            sqlCmd.Parameters.AddWithValue("@ProjectSupervisor", obj.ProjectSupervisor);
            sqlCmd.Parameters.AddWithValue("@AmendBy", obj.AmendBy);
            sqlCmd.Parameters.AddWithValue("@AmendDate", obj.AmendDate);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value; sqlConn.Open();
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

    public int Delete(ProjectPhase obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delProjectPhase", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ProjPhaseID", obj.ProjPhaseID);
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

    public List<ProjectPhase> Retrieve()
    {
        List<ProjectPhase> result = GetData();
        return result;
    }

    public ProjectPhase SelectByProjPhaseID(int ProjPhaseID)
    {
        ProjectPhase result = Retrieve().Where(obj => obj.ProjPhaseID.Equals(ProjPhaseID)).FirstOrDefault();
        return result;
    }

    protected List<ProjectPhase> GetData()
    {
        List<ProjectPhase> result = new List<ProjectPhase>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM ProjectPhase";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                ProjectPhase obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected ProjectPhase ToObj(DataRow row)
    {
        ProjectPhase obj = null;
        try
        {
            int projphaseid = CommonBL.IntegerMapper(row["ProjPhaseID"].ToString());
            DateTime startdate = CommonBL.DateTimeMapper(row["StartDate"].ToString());
            DateTime enddate = CommonBL.DateTimeMapper(row["EndDate"].ToString());
            string projlead = CommonBL.StringMapper(row["ProjectLead"]);
            string m2 = CommonBL.StringMapper(row["Member2"]);
            string m3 = CommonBL.StringMapper(row["Member3"]);
            string m4 = CommonBL.StringMapper(row["Member4"]);
            string projsup = CommonBL.StringMapper(row["ProjectSupervisor"]);
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());


            obj = new ProjectPhase(projphaseid, startdate, enddate, projlead, m2, m3, m4, projsup, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }
}
