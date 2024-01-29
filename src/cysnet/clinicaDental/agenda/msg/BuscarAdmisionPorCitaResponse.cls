Class cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse Extends Ens.Response
{

Property idAdmision As %Integer;

Property idCita As %String;

Property fechaAdmision As %TimeStamp;

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="BuscarAdmisionPorCitaResponseDefaultData">
<Subscript>"BuscarAdmisionPorCitaResponse"</Subscript>
<Value name="1">
<Value>idAdmision</Value>
</Value>
<Value name="2">
<Value>idCita</Value>
</Value>
<Value name="3">
<Value>fechaAdmision</Value>
</Value>
<Value name="4">
<Value>exito</Value>
</Value>
<Value name="5">
<Value>error</Value>
</Value>
</Data>
<DefaultData>BuscarAdmisionPorCitaResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
