Class cysnet.clinicaDental.agenda.dtl.InfoModificarCitaToSIUS12 Extends Ens.DataTransformDTL [ DependsOn = (cysnet.clinicaDental.agenda.msg.struct.InfoModificarCita, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='cysnet.clinicaDental.agenda.msg.struct.InfoModificarCita' targetClass='EnsLib.HL7.Message' targetDocType='2.5:SIU_S12' create='new' language='objectscript' >
<assign value='"BOOTCAMP"' property='target.{MSH:SendingApplication}' action='set' />
<assign value='"IRIS"' property='target.{MSH:SendingFacility}' action='set' />
<assign value='"CLINICADENTAL"' property='target.{MSH:ReceivingApplication}' action='set' />
<assign value='..CurrentDateTime()' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='"SIU"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<assign value='"S12"' property='target.{MSH:MessageType.TriggerEvent}' action='set' />
<assign value='"P"' property='target.{MSH:ProcessingID.ProcessingID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID.VersionID}' action='set' />
<assign value='source.cita.idCita' property='target.{SCH:PlacerAppointmentID}' action='set' />
<assign value='source.cita.descCita' property='target.{SCH:AppointmentReason.Text}' action='set' />
<assign value='source.cita.fechaCita' property='target.{SCH:AppointmentTimingQuantity(1).StartDateTime}' action='set' />
<assign value='1' property='target.{PIDgrp(1).PID:SetIDPID}' action='set' />
<assign value='source.cita.idPaciente' property='target.{PIDgrp(1).PID:PatientID.IDNumber}' action='set' />
<assign value='"ID"' property='target.{PIDgrp(1).PID:PatientID.IdentifierTypeCode}' action='set' />
<assign value='source.paciente.apellidos' property='target.{PIDgrp(1).PID:PatientName(1).FamilyName}' action='set' />
<assign value='source.paciente.nombre' property='target.{PIDgrp(1).PID:PatientName(1).GivenName}' action='set' />
</transform>
}

}
