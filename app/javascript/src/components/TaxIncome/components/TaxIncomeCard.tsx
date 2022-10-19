import { Text } from "@nextui-org/react";
import { TaxIncome } from "../../../storage/types";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";


const TaxIncomeCard = (props: {taxIncome: TaxIncome}) => {

    const {taxIncome} = props;

    const renderStatus = () => {
        switch (taxIncome.state) {
            case "pending_assignation":
                return <WaitingLawyer/>
            case "waiting_for_meeting_creation":
                return <MeetingCreation taxIncome={taxIncome}/>;
            case "waiting_for_meeting":
                return <WaitingMeeting taxIncome={taxIncome}/>;
            case "pending_documentation":
                return <Text>Peding documentation</Text>;
            case "in_progress":
                return <Text>In progress</Text>;
            case "finished":
                return <Text> finished</Text>;
            case "rejected":
                return <Text>rejected</Text>;
            default:
                return <Text> No sabemos que ha pasado</Text>        
            
        }
    }

    return (
        renderStatus()
    )
}

export default TaxIncomeCard;