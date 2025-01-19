local Translations = {
    error = {
        finish_your_work = "Finish your job first",
        not_right_vehicle = "This is not the right vehicle",
        failed = "Failed",
        must_be_towing_vehicle = "You must be in a tow truck first",
        no_work_done = "You have not done any work yet.",
        closest_vehicle_not_delivery_truck = "Closest vehicle was not the delivery truck",
        no_vehicle_nearby = "No vehicle was nearby",
        not_enough_money_deposit = "Not enough money, the deposit is $%{price}",
        impound_flatbed_needed = "You need a flatbed from the impound.",
    },
    success = {
        take_vehicle_hayes_depot = "Take The Vehicle To Hayes Depot",
        vehicle_towed = "Vehicle Towed",
        vehicle_taken_off = "Vehicle Taken Off",
        vehicle_stored = "Vehicle Stored",
        deposit_of_paid = "You have deposited the amount of $%{price}, - paid",
        you_have_paid = "You have paid the deposit Of $%{price} Paid",
        you_got_back = "You got back $%{price} from your deposit",
        you_got_paid = "You got paid $%{payment} thank you for your service",
    },
    info = {
        take_out_flatbed = "Take out the Flatbed",
        store_the_flatbed = "Store the flatbed",
        collect_payslip = "Collect Payslip",
        tow = "Tow",
        current_task = "CURRENT TASK",
        available_trucks = "Available Trucks",
        close_menu = "⬅ Close Menu",
        someone_called_tow = "Someone called for a tow, go to the location",
        hoisting_vehicle = "Hoisting the Vehicle...",
        take_vehicle_impound_lot = "Take the vehicle to the impoundlot",
        removing_vehicle = "Removing vehicle...",
        vehicle_delivered = "You Have Delivered A Vehicle, Standby.",
        new_vehicle_for_pickup = "A New Vehicle Can Be Picked Up",
        toggle_npc_job = "Toggle Npc Job",
    },
    email = {
        sender = "Floyd",
        subject = "Tow Job",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
