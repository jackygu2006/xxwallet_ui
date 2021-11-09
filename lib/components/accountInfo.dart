import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_ui/components/addressIcon.dart';
import 'package:polkawallet_ui/components/jumpToBrowserLink.dart';
import 'package:polkawallet_ui/utils/format.dart';
import 'package:polkawallet_ui/utils/index.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo(
      {this.accInfo,
      this.address,
      this.icon,
      this.network,
      this.cmixRoot,
      this.cmixId,
      this.cmixStr,
      this.points,
      this.currentPoints});
  final Map? accInfo;
  final String? address;
  final String? icon;
  final String? network;
  final String? cmixRoot;
  final String? cmixId;
  final String? cmixStr;
  final int? points;
  final int? currentPoints;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (accInfo != null) {
      List<Widget> ls = [];
      accInfo!['identity'].keys.forEach((k) {
        if (k != 'judgements' && k != 'other') {
          String? content = accInfo!['identity'][k].toString();
          if (k == 'parent') {
            content = Fmt.address(content);
          }
          ls.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 80,
                child: Text(k),
              ),
              Expanded(child: Text(content!)),
            ],
          ));
        }
      });

      if (ls.length > 0) {
        list.add(Divider());
        list.add(Container(height: 4));
        list.addAll(ls);
      }
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: AddressIcon(address, svg: icon),
        ),
        accInfo != null ? Text(accInfo!['accountIndex'] ?? '') : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [UI.accountDisplayName(address, accInfo, expand: false)],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16, top: 8),
          child: Text(Fmt.address(address)!),
        ),
        // if xxnetwork
        points != null && currentPoints != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 16, top: 4),
                child:
                    Text('Points: current ${currentPoints.toString()}, last ${points.toString()}'),
              )
            : Container(),
        cmixStr != '' && cmixStr != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: JumpToBrowserLink(
                      'https://protonet-dashboard.xx.network/nodes/$cmixId',
                      text: 'Cmix Node: ' + cmixStr!,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: JumpToBrowserLink(
                      'https://polkascan.io/$network/account/$address',
                      text: 'Polkascan',
                    ),
                  ),
                  JumpToBrowserLink(
                    'https://$network.subscan.io/account/$address',
                    text: 'Subscan',
                  ),
                ],
              ),
        accInfo == null
            ? Container()
            : Container(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: list),
              )
      ],
    );
  }
}
