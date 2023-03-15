# gmod-netcapture
Analyze the network load of your Garrys Mod server and find bottlenecks


#### General Purpose
Garry's Mod NetCapture is an addon for Garry's Mod server that allows administrators to monitor network traffic in real-time and capture information for analysis and debugging purposes.


> #### Note
> Please note that this script will temporarly modify the net receiver on your client and can lead to unexpected behaviour.
> However since this is only client-side, it will not break anything for other players and it will always be resetted after reconnecting.

***

## Installation

1. Download the `gmod_netcapture` folder from this repository.
2. Locate the Garry's Mod server installation directory on your system.
3. Navigate to the `addons` folder within the Garry's Mod server directory.
4. Copy the `netcapture` folder into the `addons` folder.
5. The directory should be `/garrysmod/addons/netcapture/lua/autorun/client/netcapture.lua`
6. Restart your server

That's it! The NetCapture addon is now installed on your server.

***

## Usage

To use the GMod NetCapture addon, follow these steps:

1. Start your Garry's Mod server.
2. As an administrator, open the console when you are on the server.
3. Type the following command to start capturing network traffic:
> netcapture_start
4. To stop capturing network traffic, type the following command in the server console:
> netcapture_stop
5. The captured network data will be printed out to your console and also saved to your local `/garrysmod/data` folder (in your local game, not the server).

You can analyze the captured data to troubleshoot any network-related issues or optimize your server performance.

***

## Contributing

If you'd like to contribute to this project or report any issues, please create a pull request or submit an issue through the GitHub repository.

***

## License

This project is licensed under a custom license. Please read the LICENSE file for more information.
