Class cysnet.clinicaDental.agenda.dtl.InfoAltaPacienteToADTA03 Extends Ens.DataTransformDTL [ DependsOn = (cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente' targetClass='EnsLib.HL7.Message' targetDocType='2.5:ADT_A03' create='new' language='objectscript' >
<assign value='"BOOTCAMP"' property='target.{MSH:SendingApplication}' action='set' />
<assign value='"IRIS"' property='target.{MSH:SendingFacility}' action='set' />
<assign value='"CLINICADENTAL"' property='target.{MSH:DateTimeOfMessage.Time}' action='set' />
<assign value='"CLINICADENTAL"' property='target.{MSH:ReceivingApplication}' action='set' />
<assign value='..CurrentDateTime()' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='"ADT"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<assign value='"A03"' property='target.{MSH:MessageType.TriggerEvent}' action='set' />
<assign value='"P"' property='target.{MSH:ProcessingID.ProcessingID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID.VersionID}' action='set' />
<assign value='"A03"' property='target.{EVN:EventTypeCode}' action='set' />
<assign value='..CurrentDateTime()' property='target.{EVN:RecordedDateTime}' action='set' />
<assign value='1' property='target.{PID:SetIDPID}' action='set' />
<assign value='source.idPaciente' property='target.{PID:PatientID}' action='set' />
<assign value='source.apellido' property='target.{PID:PatientName().FamilyName}' action='set' />
<assign value='source.nombre' property='target.{PID:PatientName().GivenName}' action='set' />
<assign value='1' property='target.{PV1:SetIDPV1}' action='set' />
<assign value='source.idAdmision' property='target.{PV1:VisitNumber}' action='set' />
<assign value='source.fechaAdmision' property='target.{PV1:AdmitDateTime}' action='set' />
<assign value='source.fechaAlta' property='target.{PV1:DischargeDateTime()}' action='set' />
<assign value='"ID"' property='target.{PID:PatientIdentifierList().IdentifierTypeCode}' action='set' />
</transform>
}

}