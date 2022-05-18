using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ResponseBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(Response obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addResponse", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ResponseID", obj.ResponseID);
            sqlCmd.Parameters.AddWithValue("@DateTimeStamp", obj.DateTimeStamp);
            sqlCmd.Parameters.AddWithValue("@FacilityID", obj.FacilityID);
            sqlCmd.Parameters.AddWithValue("@RespondentID", obj.RespondentID);
            sqlCmd.Parameters.AddWithValue("@QnsID", obj.QnsID);
            sqlCmd.Parameters.AddWithValue("@RespDesc", obj.RespDesc);
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

    public int Update(Response obj)
    {
        //TODO
        throw new NotImplementedException();
    }

    public int Delete(Response obj)
    {
        //TODO
        throw new NotImplementedException();
    }

    public List<Response> Retrieve()
    {
        List<Response> result = GetData();
        return result;
    }

    protected List<Response> GetData()
    {
        List<Response> result = new List<Response>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM Response";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Response obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Response ToObj(DataRow row)
    {
        Response obj = null;
        try
        {
            int id = CommonBL.IntegerMapper(row["ID"].ToString());
            string responseid = CommonBL.StringMapper(row["ResponseID"]);
            DateTime dtstamp = CommonBL.DateTimeMapper(row["DateTimeStamp"].ToString());
            string faciid = CommonBL.StringMapper(row["FacilityID"]);
            string respondentid = CommonBL.StringMapper(row["RespondentID"]);
            int qnsid = CommonBL.IntegerMapper(row["QnsID"].ToString());
            string respdesc = CommonBL.StringMapper(row["RespDesc"]);
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new Response(id, responseid, dtstamp, faciid, respondentid, qnsid, respdesc, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }
}
