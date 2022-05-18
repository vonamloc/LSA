using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Response
{
    public int ID { get; set; }
    public string ResponseID { get; set; }
    public DateTime DateTimeStamp { get; set; }
    public string FacilityID { get; set; }
    public string RespondentID { get; set; }
    public int QnsID { get; set; }
    public string RespDesc { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Response()
    {

    }

    public Response(int id, string respid, DateTime dtstamp, string faciid, string respondentid, int qnsid, string respdesc, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        ID = id;
        ResponseID = respid;
        DateTimeStamp = dtstamp;
        FacilityID = faciid;
        RespondentID = respondentid;
        QnsID = qnsid;
        RespDesc = respdesc;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
