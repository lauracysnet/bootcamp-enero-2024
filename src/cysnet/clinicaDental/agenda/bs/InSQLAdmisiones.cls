Class cysnet.clinicaDental.agenda.bs.InSQLAdmisiones Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Method OnProcessInput(pInput As EnsLib.SQL.Snapshot, Output pOutput As %RegisteredObject) As %Status
{
    #dim req as cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest
    #dim rsp As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse

    set req = ##class(cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest).%New()
    set req.idCita = pInput.Get("idCita")
    quit ..SendRequestSync("ProcesoCitas",req,.rsp)
}

}
