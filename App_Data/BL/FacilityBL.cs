using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class FacilityBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(Facility obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addFacility", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@FacilityCode", obj.FacilityCode);
            sqlCmd.Parameters.AddWithValue("@ProjPhaseID", obj.ProjPhaseID);
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

    public int Update(Facility obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updFacility", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@FacilityCode", obj.FacilityCode);
            sqlCmd.Parameters.AddWithValue("@ProjPhaseID", obj.ProjPhaseID);
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

    public int Delete(string faciid)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delFacility", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@FacilityID", faciid);
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

    public List<Facility> Retrieve()
    {
        List<Facility> result = GetData();
        return result;
    }

    public Facility SelectByFacilityID(string faciid)
    {
        Facility result = Retrieve().Where(obj => obj.FacilityID.Equals(faciid)).FirstOrDefault();
        return result;
    }

    public Facility SelectByFacilityCode(string facicode)
    {
        Facility result = Retrieve().Where(obj => obj.FacilityCode.Equals(facicode)).FirstOrDefault();
        return result;
    }

    protected List<Facility> GetData()
    {
        List<Facility> result = new List<Facility>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM Facility";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Facility obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Facility ToObj(DataRow row)
    {
        Facility obj = null;
        try
        {
            string faciid = row.Table.Columns.Contains("FacilityID") ? CommonBL.StringMapper(row["FacilityID"]) : "";
            string facicode = row.Table.Columns.Contains("FacilityCode") ? CommonBL.StringMapper(row["FacilityCode"]) : "";
            int projphaseid = row.Table.Columns.Contains("ProjPhaseID") ? CommonBL.IntegerMapper(row["ProjPhaseID"].ToString()) : 0;
            string cBy = row.Table.Columns.Contains("CreateBy") ? CommonBL.StringMapper(row["CreateBy"]) : "";
            DateTime cDate = row.Table.Columns.Contains("CreateDate") ? CommonBL.DateTimeMapper(row["CreateDate"].ToString()) : new DateTime();
            string aBy = row.Table.Columns.Contains("AmendBy") ? CommonBL.StringMapper(row["AmendBy"]) : "";
            DateTime aDate = row.Table.Columns.Contains("AmendDate") ? CommonBL.DateTimeMapper(row["AmendDate"].ToString()) : new DateTime();

            obj = new Facility(faciid, facicode, projphaseid, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    public string Validate(Facility ValObj, string reqtype)
    {
        StringBuilder errorMsg = new StringBuilder();
        if (string.IsNullOrEmpty(ValObj.FacilityID))
        {
            errorMsg.Append("Please complete all fields.<br/>");
        }

        Facility FaciObj = SelectByFacilityID(ValObj.FacilityID);
        if (FaciObj != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("Facility already exists. Please try another ID.<br/>");
            }
        }

        return errorMsg.ToString();
    }
}
