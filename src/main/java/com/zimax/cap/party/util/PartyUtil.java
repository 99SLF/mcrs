package com.zimax.cap.party.util;

import com.zimax.cap.party.PartyType;
import com.zimax.cap.party.impl.PartyTypeTreeModel;
import com.zimax.cap.party.manager.PartyTypeManager;

import java.util.Comparator;

/**
 * 参与者工具类
 *
 * @author 苏尚文
 * @date 2022/12/2 17:30
 */
public class PartyUtil {

    private static Comparator<PartyType> partyTypeComparator = null;

    private static Comparator<PartyTypeTreeModel.PartyTypeTreeNode> partyTypeTreeNodeComparator = null;

    public static Comparator<PartyType> getPartyTypeComparator() {
        if (partyTypeComparator == null) {
            partyTypeComparator = new Comparator<PartyType>() {
                public int compare(PartyType o1, PartyType o2) {
                    int priority1 = o1.getPriority();
                    int priority2 = o2.getPriority();
                    if (priority1 > priority2) {
                        return 1;
                    }
                    if (priority1 < priority2) {
                        return -1;
                    }
                    return 0;
                }
            };
        }
        return partyTypeComparator;
    }

    public static Comparator<PartyTypeTreeModel.PartyTypeTreeNode> getPartyTypeTreeNodeComparator() {
        if (partyTypeTreeNodeComparator == null) {
            partyTypeTreeNodeComparator = new Comparator<PartyTypeTreeModel.PartyTypeTreeNode>() {
                public int compare(PartyTypeTreeModel.PartyTypeTreeNode o1,
                                   PartyTypeTreeModel.PartyTypeTreeNode o2) {
                    String partyTypeID1 = o1.getPartyTypeID();
                    String partyTypeID2 = o2.getPartyTypeID();
                    PartyType partyType1 = PartyTypeManager.getInstance()
                            .getPartyType(partyTypeID1);
                    PartyType partyType2 = PartyTypeManager.getInstance()
                            .getPartyType(partyTypeID2);
                    int priority1 = partyType1.getPriority();
                    int priority2 = partyType2.getPriority();
                    if (priority1 > priority2) {
                        return 1;
                    }
                    if (priority1 < priority2) {
                        return -1;
                    }
                    return 0;
                }
            };
        }
        return partyTypeTreeNodeComparator;
    }
}
